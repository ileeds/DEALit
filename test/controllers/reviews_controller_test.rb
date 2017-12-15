require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:one)
    @home = homes(:one)
    @user = users (:one)
  end

  test "should get index" do
    get home_reviews_url(@home)
    assert_response :success
  end

  test "should get new" do
    skip("skip this")
    get new_home_review_url(@home)
    assert_response :success
  end


  test "should show review" do
    get home_review_url(@home, @review)
    assert_response :success
  end

  test "should get edit" do
    get edit_home_review_url(@home, @review)
    assert_response :success
  end


  test "should destroy review" do
    assert_difference('Review.count', -1) do
      delete home_review_url(@home, @review)
    end
    assert_redirected_to home_reviews_url(@home)
  end
end
