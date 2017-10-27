require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search = searches(:one)
  end

  test "should get index" do
    skip("not valid test")
    get searches_url
    assert_response :success
  end

  test "should get new" do
        skip("not valid test")
    get new_search_url
    assert_response :success
  end

  test "should create search" do
        skip("not valid test")
    assert_difference('Search.count') do
      post searches_url, params: { search: { details: @search.details, user_id: @search.user_id } }
    end

    assert_redirected_to search_url(Search.last)
  end

  test "should show search" do
        skip("not valid test")
    get search_url(@search)
    assert_response :success
  end

  test "should get edit" do
        skip("not valid test")
    get edit_search_url(@search)
    assert_response :success
  end

  test "should update search" do
    skip("not valid test")
    patch search_url(@search), params: { search: { details: @search.details, user_id: @search.user_id } }
    assert_redirected_to search_url(@search)
  end

  test "should destroy search" do
        skip("not valid test")
    assert_difference('Search.count', -1) do
      delete search_url(@search)
    end

    assert_redirected_to searches_url
  end
end
