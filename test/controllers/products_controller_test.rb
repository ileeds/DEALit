require 'test_helper'
require 'byebug'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # user must exist for product to exist
    @user = users(:one)
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { address: @product.address, bathrooms: @product.bathrooms, description: @product.description, end_date: @product.end_date, is_furnished: @product.is_furnished, price: @product.price, rooms_available: @product.rooms_available, size: @product.size, start_date: @product.start_date, total_rooms: @product.total_rooms, user_id: @product.user_id } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: { product: { address: @product.address, bathrooms: @product.bathrooms, description: @product.description, end_date: @product.end_date, is_furnished: @product.is_furnished, price: @product.price, rooms_available: @product.rooms_available, size: @product.size, start_date: @product.start_date, total_rooms: @product.total_rooms, user_id: @product.user_id } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
