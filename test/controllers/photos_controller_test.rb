require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @photo = photos(:one)
    @photo.home_id = homes(:one).id
  end

  test "should get index" do
    skip("redo test for this")
    get photos_url
    assert_response :success
  end

  test "should get new" do
    skip("skip")
    get new_photo_url
    assert_response :success
  end

  test "should create photo" do
    skip("For Yan")
    assert_difference('Photo.count') do
      post photos_url, params: { photo: { filename: @photo.filename, home_id:@photo.home_id } }
    end
    assert_redirected_to photo_url(Photo.last)
  end

  test "should show photo" do
    skip("redo test for this")
    get photo_url(@photo)
    assert_response :success
  end

  test "should get edit" do
    skip("skip")
    get edit_photo_url(@photo)
    assert_response :success
  end

  test "should update photo" do
    skip("For Yan")
    patch photo_url(@photo), params: { photo: { filename: @photo.filename, home_id:@photo.home_id  } }
    assert_redirected_to photo_url(@photo)
  end

  test "should destroy photo" do
    skip("skip")
    assert_difference('Photo.count', -1) do
      delete photo_url(@photo)
    end
    #assert_template partial: 'homes/_form'
  end
end
