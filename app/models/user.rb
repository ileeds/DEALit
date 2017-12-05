class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :homes
  has_many :followings
  has_many :reviews
  has_many :comments
  has_many :searches
  acts_as_messageable
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  after_save :first_private_topic

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.password = user.password_confirmation = "aaaaaa"
      user.password_digest = "google_oauth2 authorized account"
      if auth.extra.raw_info.hd != "brandeis.edu"
        user.errors.add(:email, "must be from Brandeis")
      elsif User.where(email: auth.info.email).blank?
        user.save!
      end
    end
  end

  def mailboxer_email(object)
    nil
  end

  private

    def first_private_topic
      if id!=1
        admin_topic = Thredded::PrivateTopic.new(user_id: id, title: "Welcome to OffCampus!", created_at: Time.now, last_post_at: Time.now, last_user_id: 1)
        admin_topic.users << User.find(id)
        admin_topic.users << User.find(1)
        admin_topic.save!
        Thredded::PrivatePost.create(user: User.find(1), content: "Have any comments/concerns about OffCampus? Send us a message here!", postable: admin_topic)
      end
    end
end
