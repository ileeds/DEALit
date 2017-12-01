require 'test_helper'

class ReviewsControllerIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user_other = users(:two)
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    @home = homes(:one)
    @home.user_id = @user.id
    @home.save!
    @review = reviews(:one)
  end
test "should create review" do
  assert_difference('Review.count') do
    post home_reviews_url(@home), params: { review: { description: @review.description, home_id: @home.id, user_id: @user.id }}
  end
  assert_redirected_to home_review_url(@home, Review.last)
end

test "should update review" do
  patch home_review_url(@home, @review), params: { review: { description: @review.description, home_id: @home.id, user_id: @user.id } }
  assert_redirected_to home_review_url(@home, @review)
end
end
