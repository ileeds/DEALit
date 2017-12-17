

class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.create(photo_params)
    @photo.home_id = params[:home_id]
    if @photo.save
      # send success header
      render json: { message: "success", fileID: @photo.id }, :status => 200
    else
      #  you need to send an error header, otherwise Dropzone
      #  will not interpret the response as an error:
      render json: { error: @photo.errors.full_messages.join(',')}, :status => 400
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    if @photo.destroy
      render json: { message: "File deleted from server" }
    else
      render json: { message: @photo.errors.full_messages.join(',') }
    end
  end

  private
  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:image, :filename)
  end
end
