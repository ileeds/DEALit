require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test "should get index" do
    get products_url
    assert_response :success
    assert "title", "<%yield(:title)%>"
  end

  test "should not save product without existing user id" do
    product=Product.new
    assert_not product.save, "Saved the product without the user id"
    user=User.new(id:2)
    assert user.save
    product2=Product.new(user_id:2)
    assert product2.save
    product1 = Product.new(user_id:75)
    assert_not product1.save, "Saved with a non-existing user id"

  end
  test "should get new" do
    get new_product_url
    assert_response :success
    assert "title", "<%yield(:title)%>"
  end

  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { address: @product.address, bathrooms: @product.bathrooms, description: @product.description, end_date: @product.end_date, is_furnished: @product.is_furnished, price: @product.price, rooms_available: @product.rooms_available, size: @product.size, start_date: @product.start_date, total_rooms: @product.total_rooms,
         user_id: @product.user_id } }
    end

    assert_redirected_to product_url(Product.last)

  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
    assert "title", "<%yield(:title)%>"
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success


  end

  test "should update product" do
    patch product_url(@product), params: { product: { address: @product.address, bathrooms: @product.bathrooms, description: @product.description, end_date: @product.end_date, is_furnished: @product.is_furnished, price: @product.price, rooms_available: @product.rooms_available, size: @product.size, start_date: @product.start_date, total_rooms:
      @product.total_rooms, user_id: @product.user_id } }
    assert_redirected_to product_url(@product)
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
