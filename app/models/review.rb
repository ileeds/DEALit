class Review < ApplicationRecord
  belongs_to :home
  belongs_to :user
  validates :description, presence:true
end
