

class Home < ApplicationRecord
  belongs_to :user
  has_one :option, :dependent => :destroy
  accepts_nested_attributes_for :option
  validates :address, presence: true
  validates :description, length: {minimum: 10, maximum: 1400 }, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: true
  validates :size, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_rooms, numericality: true, allow_nil: true
  validates :available_rooms, numericality: true, allow_nil: true
  validates :total_bathrooms, numericality: true, allow_nil: true
  validates :private_bathrooms, numericality: true, allow_nil: true
  validates :is_furnished, inclusion: { in: [ true, false ] }

  validate :dates_cannot_be_in_the_past, :start_date_before_end_date

  def dates_cannot_be_in_the_past
    today = Date.today
    if(start_date < today)
      errors.add(:start_date, "can't be in the past")
    end
    if(end_date < today)
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
      ['Price', 'price'],
      ['Size', 'size']
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
      :with_total_rooms_range,
      :with_available_rooms_range,
      :with_total_bathrooms_range,
      :with_private_bathrooms_range,
      :with_is_furnished
    ]
  )

  # sort options go here, default ascending
  scope :sorted_by, lambda { |sort_key|
    case sort_key.to_s
    when 'start_date'
      order("homes.start_date asc")
    when 'price'
      order("homes.price asc")
    when 'size'
      order("homes.size desc")
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
    start_date = Date.strptime(date_range_attrs.start_date, '%m/%d/%Y') rescue nil
    end_date = Date.strptime(date_range_attrs.end_date, '%m/%d/%Y') rescue nil

    if !start_date && !end_date
      return all
    elsif !start_date
      return where("end_date >= ?", end_date)
    elsif !end_date
      return where("start_date <= ?", start_date)
    end
    where("start_date <= ? AND end_date >= ?", start_date, end_date)
  }

  scope :with_total_rooms_range, lambda { |total_rooms_attrs|
    if total_rooms_attrs.min_rooms.blank? && total_rooms_attrs.max_rooms.blank?
      return all
    elsif total_rooms_attrs.min_rooms.blank?
      return where("total_rooms <= ?", total_rooms_attrs.max_rooms)
    elsif total_rooms_attrs.max_rooms.blank?
      return where("total_rooms >= ?", total_rooms_attrs.min_rooms)
    end
    where(total_rooms: total_rooms_attrs.min_rooms..total_rooms_attrs.max_rooms)
  }

  scope :with_available_rooms_range, lambda { |available_rooms_attrs|
    if available_rooms_attrs.min_rooms.blank? && available_rooms_attrs.max_rooms.blank?
      return all
    elsif available_rooms_attrs.min_rooms.blank?
      return where("available_rooms <= ?", available_rooms_attrs.max_rooms)
    elsif available_rooms_attrs.max_rooms.blank?
      return where("available_rooms >= ?", available_rooms_attrs.min_rooms)
    end
    where(available_rooms: available_rooms_attrs.min_rooms..available_rooms_attrs.max_rooms)
  }

  scope :with_total_bathrooms_range, lambda { |bathrooms_attrs|
    if bathrooms_attrs.min_rooms.blank? && bathrooms_attrs.max_rooms.blank?
      return all
    elsif bathrooms_attrs.min_rooms.blank?
      return where("total_bathrooms <= ?", bathrooms_attrs.max_rooms)
    elsif bathrooms_attrs.max_rooms.blank?
      return where("total_bathrooms >= ?", bathrooms_attrs.min_rooms)
    end
    where(total_bathrooms: bathrooms_attrs.min_rooms..bathrooms_attrs.max_rooms)
  }

  scope :with_private_bathrooms_range, lambda { |bathrooms_attrs|
    if bathrooms_attrs.min_rooms.blank? && bathrooms_attrs.max_rooms.blank?
      return all
    elsif bathrooms_attrs.min_rooms.blank?
      return where("private_bathrooms <= ?", bathrooms_attrs.max_rooms)
    elsif bathrooms_attrs.max_rooms.blank?
      return where("private_bathrooms >= ?", bathrooms_attrs.min_rooms)
    end
    where(private_bathrooms: bathrooms_attrs.min_rooms..bathrooms_attrs.max_rooms)
  }

  scope :with_is_furnished, lambda { |furnished|
    where(is_furnished: furnished)
  }

end
