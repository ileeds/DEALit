class Product < ApplicationRecord
  belongs_to :user
  validates_associated :user
  validates :address, presence: true
  validates :price, presence: true, numericality: true
  validates :description, length: {minimum: 10, maximum: 1400 }, presence: true
  validates :size, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :bathrooms, numericality: true, allow_nil: true
  validates :total_rooms, numericality: true, allow_nil: true
  validates :rooms_available, numericality: true, allow_nil: true

  validate :dates_cannot_be_in_the_past, :start_date_before_end_date

  def dates_cannot_be_in_the_past
    if(start_date < Date.today)
      errors.add(:start_date, "can't be in the past")
    end
    if(end_date < Date.today)
      errors.add(:end_date, "can't be in the past")
    end
  end

  def start_date_before_end_date
    if(end_date < start_date)
      errors.add(:end_date, "cannot be before Start date")
    end
  end

end
