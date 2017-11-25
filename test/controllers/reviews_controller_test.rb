require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @review = reviews(:one)
    @home = homes(:one)
  end

  test "should get index" do
    skip("redo test for this")
    get home_reviews_url(@home)
    assert_response :success
  end

  test "should get new" do
    skip("redo test for this")
    get new_home_review_url(@home)
    assert_response :success
  end

  test "should create review" do
    skip("redo test for this")
    assert_difference('Review.count') do
      post home_reviews_url(@home), params: { review: { description: @review.description, home_id: @review.home_id, user_id: @review.user_id } }
    end
    assert_redirected_to home_review_url(@home, Review.last)
  end

  test "should show review" do
    skip("redo test for this")
    get home_review_url(@home, @review)
    assert_response :success
  end

  test "should get edit" do
    skip("redo test for this")
    get edit_home_review_url(@home, @review)
    assert_response :success
  end

  test "should update review" do
    skip("redo test for this")
    patch home_review_url(@home, @review), params: { review: { description: @review.description, home_id: @review.home_id, user_id: @review.user_id } }
    assert_redirected_to home_review_url(@home, @review)
  end

  test "should destroy review" do
    skip("redo test for this")
    assert_difference('Review.count', -1) do
      delete home_review_url(@home, @review)
    end
    assert_redirected_to home_reviews_url(@home)
  end
end
