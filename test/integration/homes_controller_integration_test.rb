require 'test_helper'

class HomesControllerIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user_other = users(:two)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    @home = homes(:one)
    @home.user_id = @user.id
    @home.save!
    @option = options(:one)
  end

  test "should redirect edit when not correct user" do
    get login_path
    post login_path, params: { session: { email:    @user_other.email,
                                          password: 'password' } }
    get edit_home_path(id: @home.id)
    assert_redirected_to root_url
  end

  test "should redirect update when not correct user" do
    skip("redo test")
    get login_path
    post login_path, params: { session: { email:    @user_other.email,
                                          password: 'password' } }
    patch home_path(id: @home.id), params: { home: {option_attributes: {fireplace: @option.fireplace} } }
    assert_redirected_to root_url
  end

  test "should redirect destroy when not correct user" do
    get login_path
    post login_path, params: { session: { email:    @user_other.email,
                                          password: 'password' } }
    delete home_path(id: @home.id)
    assert_redirected_to root_url
  end

  test "should create home" do
    skip("redo test")
    assert_difference('Home.count', 1) do
      post homes_url, params: { home: { address: "110 South St, Waltham, MA 02453, USA", total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date,
        total_rooms: @home.total_rooms, title: @home.title, capacity: @home.capacity, entire_home: @home.entire_home } }
      follow_redirect!
    end
    assert_template 'homes/show'
  end

  test "should not create empty option" do
    skip("redo test")
    option_number = Option.count
    assert_difference('Home.count', 1) do
      post homes_url, params: { home: { address: "110 South St, Waltham, MA 02453, USA", total_bathrooms: @home.total_bathrooms, private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date,
         total_rooms: @home.total_rooms, title: @home.title, capacity: @home.capacity, entire_home: @home.entire_home }}
      follow_redirect!
      assert Option.count == option_number
    end
    assert_template 'homes/show'
  end

  test "should not create invalid home" do
    skip("redo test")
    assert_difference('Home.count', 0) do
      post homes_url, params: { home: { address: @home.address, total_bathrooms: "a", private_bathrooms: @home.private_bathrooms, description: @home.description, end_date: @home.end_date, is_furnished: @home.is_furnished, price: @home.price, available_rooms: @home.available_rooms, size: @home.size, start_date: @home.start_date, total_rooms: @home.total_rooms, title: @home.title, capacity: @home.capacity, entire_home: @home.entire_home } }
    end
    assert_template 'homes/new'
  end

  test "should create option when there is no option initially during update" do
    assert_difference('Option.count', 1) do
      patch home_path(id: @user.id, home_id: @home.id), params: { home: {option_attributes: {fireplace: @option.fireplace} } }
      follow_redirect!
    end
    assert_template 'homes/show'
  end

  test "should destroy home" do
    number = Option.count
    assert_difference('Home.count', -1) do
      delete home_path(id: @user.id, home_id: @home.id)
      follow_redirect!
    end
    assert_template 'homes/index'
  end
end
