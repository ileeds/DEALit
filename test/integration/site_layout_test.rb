
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
  end
  test "layout links" do

    get root_path
    assert_template 'homes/index'
    assert_select "a[href=?]", root_path, count: 2
  end
end
