require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "Off Campus Catch"
    assert_equal full_title("Homes"), "Homes | Off Campus Catch"
  end
end
