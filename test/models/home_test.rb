require 'test_helper'

class HomeTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @home = homes(:one)
    @home_two = homes(:two)
    @home_three = homes(:three)
  end

  test "dates must be valid" do
    @home.end_date = 1.day.ago
    assert !@home.valid?
    @home.end_date = 3.days.from_now
    assert !@home.valid?
    @home.start_date = 2.days.ago
    assert !@home.valid?
  end

  test "homes sorted by start_date" do
    assert Home.sorted_by("start_date").first == @home
  end

  test "homes sorted by price" do
    assert Home.sorted_by("price").first == @home_two
  end

  test "homes sorted by size" do
    assert Home.sorted_by("size").first == @home_three
  end

  test "homes sorted by invalid" do
    assert_raises ArgumentError do
      Home.sorted_by("other")
    end
  end

  test "with price range" do
    price_range_attrs = OpenStruct.new
    assert Home.with_price_range(price_range_attrs).count == 3
    price_range_attrs.min = 600
    assert Home.with_price_range(price_range_attrs).count == 2
    price_range_attrs.min = nil
    price_range_attrs.max = 700
    assert Home.with_price_range(price_range_attrs).count == 2
    price_range_attrs.min = 600
    assert Home.with_price_range(price_range_attrs).take == @home
  end

  test "with availability range" do
    date_range_attrs = OpenStruct.new
    assert Home.with_availability_range(date_range_attrs).count == 3
    date_range_attrs.dates = 7.days.from_now.strftime("%m/%e/%Y")
    assert Home.with_availability_range(date_range_attrs).count == 2
    date_range_attrs.dates = ' - ' + (1.year.from_now + 1.day).strftime("%m/%e/%Y")
    assert Home.with_availability_range(date_range_attrs).count == 2
    date_range_attrs.dates = 7.days.from_now.strftime("%m/%e/%Y") + date_range_attrs.dates
    assert Home.with_availability_range(date_range_attrs).take == @home_two
  end

  test "with total rooms range" do
    total_rooms_attrs = OpenStruct.new
    assert Home.with_total_rooms_range(total_rooms_attrs).count == 3
    total_rooms_attrs.min = 2
    assert Home.with_total_rooms_range(total_rooms_attrs).count == 2
    total_rooms_attrs.min = nil
    total_rooms_attrs.max = 4
    assert Home.with_total_rooms_range(total_rooms_attrs).count == 2
    total_rooms_attrs.min = 2
    assert Home.with_total_rooms_range(total_rooms_attrs).take == @home_three
  end

  test "with available rooms range" do
    available_rooms_attrs = OpenStruct.new
    assert Home.with_available_rooms_range(available_rooms_attrs).count == 3
    available_rooms_attrs.min = 2
    assert Home.with_available_rooms_range(available_rooms_attrs).count == 2
    available_rooms_attrs.min = nil
    available_rooms_attrs.max = 4
    assert Home.with_available_rooms_range(available_rooms_attrs).count == 2
    available_rooms_attrs.min = 2
    assert Home.with_available_rooms_range(available_rooms_attrs).take == @home_three
  end

  test "with total bathrooms range" do
    bathroom_attrs = OpenStruct.new
    assert Home.with_total_bathrooms_range(bathroom_attrs).count == 3
    bathroom_attrs.min = 4
    assert Home.with_total_bathrooms_range(bathroom_attrs).count == 2
    bathroom_attrs.min = nil
    bathroom_attrs.max = 5
    assert Home.with_total_bathrooms_range(bathroom_attrs).count == 2
    bathroom_attrs.min = 4
    assert Home.with_total_bathrooms_range(bathroom_attrs).take == @home_two
  end

  test "with private bathrooms range" do
    bathroom_attrs = OpenStruct.new
    assert Home.with_private_bathrooms_range(bathroom_attrs).count == 3
    bathroom_attrs.min = 4
    assert Home.with_private_bathrooms_range(bathroom_attrs).count == 2
    bathroom_attrs.min = nil
    bathroom_attrs.max = 5
    assert Home.with_private_bathrooms_range(bathroom_attrs).count == 2
    bathroom_attrs.min = 4
    assert Home.with_private_bathrooms_range(bathroom_attrs).take == @home_two
  end

  test "with is furnished" do
    assert Home.with_is_furnished(true).take == @home
  end

end
