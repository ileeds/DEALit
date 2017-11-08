require 'test_helper'
include SessionsHelper

class HomesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # user must exist for home to exist
    @user = users(:one)
    @user.password="password"
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    @home = homes(:one)
    @home.user_id = @user.id
    @option =options(:one)
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
      post homes_url, params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date,
        total_rooms: @home.total_rooms, user_id: @user.id, option_attributes:{capacity: @option.capacity}} }
      assert Option.count == 3
      assert Home.count == 4
      assert_redirected_to home_url(Home.last)
    end
  end

  test "should not create empty option" do
    skip("redo test for this")
    home_number = Home.count
    option_number = Option.count
    assert Option.count == 2
    assert_difference('Home.count') do
      post homes_url, params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date,
         total_rooms: @home.total_rooms, user_id: @user.id }}
      assert Option.count == option_number
      assert Home.count == home_number+1
      assert_redirected_to home_url(Home.last)
    end
  end

  test "should not create home while logged out" do
    delete logout_path
    assert_no_difference('Home.count') do

      post homes_url, params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id: @user.id} }

    end
    assert current_user == nil
    assert_redirected_to login_path
  end

  test "should not create invalid home" do
    post homes_url, params: { home: { address: @home.address, total_bathrooms: "a", private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id: @home.user_id } }
    assert_template :new
  end

  test "should show home" do
    skip("redo test for this")
    get home_url(@home)
    assert_response :success
  end

  test "should get edit" do
    get edit_home_url(@home)
    assert_response :success
  end

  test "should create option when there is no option initially during update" do
    count = Option.count
    patch home_url(@home), params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id: @home.user_id,option_attributes:{capacity: @option.capacity} } }
    assert Option.count == count+1
    assert_redirected_to home_url(@home)
  end

  test "should update home" do
    skip("redo test for this")
    patch home_url(@home), params: { home: { address: @home.address, total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id: @home.user_id } }
    assert_redirected_to home_url(@home)
  end

  test "should not update home with invalid attributes" do
    patch home_url(@home), params: { home: { address: @home.address, total_bathrooms: "a", private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, user_id: @home.user_id } }
    assert @home.total_bathrooms == 5.5
    assert_template :edit
  end

  test "should destroy home" do
    skip("redo test for this")
    number = Option.count
    assert_difference('Home.count', -1) do
      delete home_url(@home)
    end
    assert_redirected_to homes_url
  end
end
