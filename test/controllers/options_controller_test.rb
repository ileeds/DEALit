require 'test_helper'
require 'sessions_helper'
class OptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user.password="password"
    sign_up_as @user
    log_in_as @user
    @home = homes(:one)
    @option = options(:one)
  end

  test "should get index" do
    get options_url
    assert_response :success
  end

  test "should get new" do
    get new_option_url
    assert_response :success
  end

  test "should create option" do

    
    assert_difference('Option.count') do
        byebug
        post homes_url, params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id:@user.id, option_attributes: [ac: @option.ac, apartment: @option.apartment, beds: @option.beds, bike: @option.bike, broker: @option.broker, capacity: @option.capacity, closet: @option.closet, deposit: @option.deposit, dish_washer: @option.dish_washer, doorman: @option.doorman, dryer: @option.dryer, elevator: @option.elevator, events: @option.events, fireplace: @option.fireplace, floors: @option.floors, free_parking: @option.free_parking, garbage_disposal: @option.garbage_disposal, gated: @option.gated, gym: @option.gym, heat_price: @option.heat_price, heated: @option.heated, hot_tub: @option.hot_tub, house: @option.house, intercom: @option.intercom, kitchen: @option.kitchen, laundry: @option.laundry, laundry_free: @option.laundry_free, lawn: @option.lawn, lock: @option.lock, microwave: @option.microwave, patio: @option.patio, pets: @option.pets, pool: @option.pool, porch: @option.porch, refrigerator: @option.refrigerator, size_of_house: @option.size_of_house, smoking: @option.smoking, soundproof: @option.soundproof, storage: @option.storage, stove: @option.stove, street_parking: @option.street_parking, subletting: @option.subletting, tv: @option.tv, utilities_included: @option.utilities_included, water_price: @option.water_price, wheelchair: @option.wheelchair, wireless: @option.wireless] } }

    end

    assert_redirected_to option_url(Option.last)
  end

  test "should show option" do

    get option_url(@option)
    assert_response :success
  end

  test "should get edit" do
    get edit_option_url(@option)
    assert_response :success
  end

  test "should update option" do
    patch option_url(@option), params: { option: { ac: @option.ac, apartment: @option.apartment, beds: @option.beds, bike: @option.bike, broker: @option.broker, capacity: @option.capacity, closet: @option.closet, deposit: @option.deposit, dish_washer: @option.dish_washer, doorman: @option.doorman, dryer: @option.dryer, elevator: @option.elevator, events: @option.events, fireplace: @option.fireplace, floors: @option.floors, free_parking: @option.free_parking, garbage_disposal: @option.garbage_disposal, gated: @option.gated, gym: @option.gym, heat_price: @option.heat_price, heated: @option.heated, hot_tub: @option.hot_tub, house: @option.house, intercom: @option.intercom, kitchen: @option.kitchen, laundry: @option.laundry, laundry_free: @option.laundry_free, lawn: @option.lawn, lock: @option.lock, microwave: @option.microwave, patio: @option.patio, pets: @option.pets, pool: @option.pool, porch: @option.porch, refrigerator: @option.refrigerator, size_of_house: @option.size_of_house, smoking: @option.smoking, soundproof: @option.soundproof, storage: @option.storage, stove: @option.stove, street_parking: @option.street_parking, subletting: @option.subletting, tv: @option.tv, utilities_included: @option.utilities_included, water_price: @option.water_price, wheelchair: @option.wheelchair, wireless: @option.wireless } }

    assert_redirected_to option_url(@option)
  end

  test "should destroy option" do
    assert_difference('Option.count', -1) do
      delete option_url(@option)
    end

    assert_redirected_to options_url
  end
end
