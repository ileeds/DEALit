class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  sync :all

  sync_scope :active, -> (recipient_id) {
    where(:recipient_id => recipient_id).order(created_at: :desc).limit(5)
  }

  scope :actives, -> (recipient_id) {
    where(:recipient_id => recipient_id).order(created_at: :desc).limit(5)
  }
  scope :unread, -> (recipient_id) {
    where(:recipient_id => recipient_id, read_at: nil).order(created_at: :desc).limit(5)
  }
end
