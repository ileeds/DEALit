require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user.password = "password"
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: "test@test.com", name: "Test Tester", password: "test password" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should not create invalid user" do
    post users_url, params: { user: { email: "test", name: "Test Tester", password: "test password" } }
    assert_template :new
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name, password: @user.password+"a" } }
    assert_redirected_to user_url(@user)
  end

  test "should not update user with invalid attributes" do
    patch user_url(@user), params: { user: { email: "bademail", name: @user.name, password: @user.password } }
    assert @user.email == "mystring@aol.com"
    assert_template :edit
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
