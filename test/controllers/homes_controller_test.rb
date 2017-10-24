require 'test_helper'
include SessionsHelper
class HomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # user must exist for home to exist
    @user = users(:one)
    @user.password="password"
    sign_up_as @user
    log_in_as @user
    @home = homes(:one)
    @home.update_attributes(start_date: 5.days.from_now, end_date: 1.year.from_now)
  end

  test "should get index" do
    get homes_url
    assert_response :success
  end

  test "should get new" do
    get new_home_url
    assert_response :success
  end

  test "should create home" do


    assert_difference('Home.count') do
      post homes_url, params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id:@user.id } }
    end


    assert_redirected_to home_url(Home.last)
  end

  test "should show home" do
    get home_url(@home)

    assert_response :success
  end

  test "should get edit" do
    get edit_home_url(@home)
    
    assert_response :success
  end

  test "should update home" do
    patch home_url(@home), params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id: @home.user_id } }
    assert_redirected_to home_url(@home)
  end

  test "should destroy home" do
    assert_difference('Home.count', -1) do
      delete home_url(@home)
    end

    assert_redirected_to homes_url
  end
end
