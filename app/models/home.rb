class Home < ApplicationRecord
  belongs_to :user
  has_one :option, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :photos, :dependent => :destroy
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
  validates :latitude, presence: true
  validates :longitude, presence: true

  validate :dates_cannot_be_in_the_past, :start_date_before_end_date

  geocoded_by :address
  before_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? and !obj.latitude? and !obj.longitude? }
  before_validation :distance_matrix

  def dates_cannot_be_in_the_past
    today = Date.today
    if start_date < today
      errors.add(:start_date, "can't be in the past")
    end
    if end_date < today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def start_date_before_end_date
    if end_date < start_date
      errors.add(:end_date, "cannot be before Start date")
    end
  end

  def distance_matrix
    modes = ['driving', 'bicycling', 'transit', 'walking']
    data_set = []
    matrix = GoogleDistanceMatrix::Matrix.new
    matrix.configure do |config|
      config.google_api_key = ENV['GOOGLE_DISTANCE_MATRIX']
      config.units = 'imperial'
    end
    here = GoogleDistanceMatrix::Place.new lng: longitude, lat: latitude
    deis = GoogleDistanceMatrix::Place.new lng: -71.258663, lat: 42.364989
    matrix.origins << here
    matrix.destinations << deis
    modes.each_with_index do |mode, index|
      matrix.configuration.mode = mode
      matrix.reset!
      data_set[index] = matrix.data
    end
    # in miles and minutes
    self.driving_distance = data_set[0][0][0].distance_text.split(" ")[0].to_f
    self.driving_duration = data_set[0][0][0].duration_text.split(" ")[0].to_i
    self.bicycling_distance = data_set[1][0][0].distance_text.split(" ")[0].to_f
    self.bicycling_duration = data_set[1][0][0].duration_text.split(" ")[0].to_i
    self.transit_distance = data_set[2][0][0].distance_text.split(" ")[0].to_f rescue nil
    self.transit_duration = data_set[2][0][0].duration_text.split(" ")[0].to_i rescue nil
    self.walking_distance = data_set[3][0][0].distance_text.split(" ")[0].to_f
    self.walking_duration = data_set[3][0][0].duration_text.split(" ")[0].to_i
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
