
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user.password = "password"
    sign_up_as @user
    log_in_as @user
  end
  test "layout links" do
    
    get root_path
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
  end
end
