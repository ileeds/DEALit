require 'byebug'

class Product < ApplicationRecord
  belongs_to :user
  validates :address, presence: true
  validates :price, presence: true, numericality: true
  validates :description, length: {minimum: 10, maximum: 1400 }, presence: true
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

  # provide select options for filters
  def self.options_for_sorted_by
    [
      ['Start date', 'start_date'],
      ['Price', 'price']
    ]
  end

  def self.options_for_furnished
    [
      ['Yes', 1],
      ['No', 0]
    ]
  end

  filterrific(
    default_filter_params: { sorted_by: 'start_date' },
    # filters go here
    available_filters: [
      :sorted_by,
      :with_price_range,
      :with_availability_range,
      :with_total_rooms,
      :with_rooms_available,
      :with_bathrooms,
      :with_is_furnished
    ]
  )

  # sort options go here, default ascending
  scope :sorted_by, lambda { |sort_key|
    case sort_key.to_s
    when 'start_date'
      order("products.start_date asc")
    when 'price'
      order("products.price asc")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end
  }

  # price range, support min and max
  scope :with_price_range, lambda { |price_range_attrs|
    if price_range_attrs.min_price.blank? && price_range_attrs.max_price.blank?
      return all
    elsif price_range_attrs.min_price.blank?
      return where("price <= ?", price_range_attrs.max_price)
    elsif price_range_attrs.max_price.blank?
      return where("price >= ?", price_range_attrs.min_price)
    end
    where(price: price_range_attrs.min_price..price_range_attrs.max_price)
  }

  # date range of availability, can choose both start and end
  scope :with_availability_range, lambda { |date_range_attrs|
    start_date = Date.parse(date_range_attrs.start_date) rescue nil
    end_date = Date.parse(date_range_attrs.end_date) rescue nil
    if !start_date && !end_date
      return all
    elsif !start_date
      return where("end_date <= ?", end_date)
    elsif !end_date
      return where("start_date >= ?", start_date)
    end
    where("start_date <= ? AND end_date >= ?", start_date, end_date)
  }

  scope :with_total_rooms, lambda { |total_rooms|
    where("total_rooms >= ?", total_rooms)
  }

  scope :with_rooms_available, lambda { |rooms_available|
    where("rooms_available >= ?", rooms_available)
  }

  scope :with_bathrooms, lambda { |bathrooms|
    where("bathrooms >= ?", bathrooms)
  }

  scope :with_is_furnished, lambda { |furnished|
    where(is_furnished: furnished)
  }

end
