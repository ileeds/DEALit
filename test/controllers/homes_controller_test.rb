require 'test_helper'
include SessionsHelper

class HomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # user must exist for home to exist
    @user = users(:one)
    @home = homes(:one)
    @home.user_id = @user.id
    @option = options(:one)
  end

  test "should get index" do
    get homes_url
    assert_template 'homes/index'
    assert_response :success
  end

  test "should show home" do
    get home_url(@home)
    assert_template 'homes/show'
    assert_response :success
  end

  test "should redirect new when not logged in" do
    skip("redo test")
    get new_home_url
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    skip("redo test")
    post homes_url, params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date,
      total_rooms: @home.total_rooms, user_id: @user.id, option_attributes:{fireplace: @option.fireplace}} }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    skip("redo test")
    get edit_home_path(id: @user.id, home_id: @home.id)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    skip("redo test")
    put home_path(id: @user.id, home_id: @home.id)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    delete home_path(id: @user.id, home_id: @home.id)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
