require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "test@test.com", name: "Tester", password: "tested")
    sign_up_as(@user)
    log_in_as(@user)
  end

  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should create session" do
    post login_url, params: { session: {email: @user.email, password: @user.password} }
    assert_redirected_to @user
  end

  test "should reject invalid credentials" do
    post login_url, params: { session: {email: @user.email, password: @user.password + "a"} }
    assert_template :new
  end

  test "should destroy session" do
    delete logout_url(@user)
    assert_redirected_to root_url
  end
end
