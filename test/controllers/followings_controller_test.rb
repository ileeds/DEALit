require 'test_helper'

class FollowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @following = followings(:one)
  end

  test "should get index" do
    skip("not valid test")
    get followings_url
    assert_response :success
  end

  test "should get new" do
    skip("not valid test")
    get new_following_url
    assert_response :success
  end

  test "should create following" do
    skip("not valid test")
    assert_difference('Following.count') do
      post followings_url, params: { following: { home_id: @following.home_id, user_id: @following.user_id } }
    end

    assert_redirected_to following_url(Following.last)
  end

  test "should show following" do
    skip("not valid test")
    get following_url(@following)
    assert_response :success
  end

  test "should get edit" do
    skip("not valid test")
    get edit_following_url(@following)
    assert_response :success
  end

  test "should update following" do
    skip("not valid test")
    patch following_url(@following), params: { following: { home_id: @following.home_id, user_id: @following.user_id } }
    assert_redirected_to following_url(@following)
  end

  test "should destroy following" do
    skip("not valid test")
    assert_difference('Following.count', -1) do
      delete following_url(@following)
    end

    assert_redirected_to followings_url
  end
end
