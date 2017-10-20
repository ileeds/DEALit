require 'test_helper'

class HomeTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "Example User", email: "user@example.com",
              password: "foobar", password_confirmation: "foobar")
    @home = homes(:one)
    @home.update_attributes(start_date: 4.days.from_now, end_date: 1.year.from_now)
    @home_two = homes(:two)
    @home_two.update_attributes(start_date: 5.days.from_now, end_date: 1.year.from_now)
    @home_three = homes(:three)
    @home_three.update_attributes(start_date: 4.days.from_now, end_date: 1.year.from_now)
  end

  test "dates must be valid" do
    @home.end_date = 1.day.ago
    assert !@home.valid?
    @home.end_date = 3.days.from_now
    assert !@home.valid?
    @home.start_date = 1.day.ago
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
    price_range_attrs.min_price = 500
    price_range_attrs.max_price = 800
    assert Home.with_price_range(price_range_attrs).count == 3
    price_range_attrs.min_price = 600
    assert Home.with_price_range(price_range_attrs).count == 2
    price_range_attrs.max_price = 700
    assert Home.with_price_range(price_range_attrs).take == @home
  end

end
