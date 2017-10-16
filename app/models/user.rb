class User < ApplicationRecord
  has_many :homes
  validates :name, presence: true
  validates :email, presence: true
  before_save   :downcase_email
  has_secure_password

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
end
