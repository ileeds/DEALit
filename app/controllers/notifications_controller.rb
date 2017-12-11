class NotificationsController < ApplicationController
  before_action :logged_in_user
  def index
    @notifications = Notification.where(recipient: current_user).limit(10).order(created_at: :desc)
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    #@notifications = Notification.where(recipient: current_user).unread
    @notification.update(read_at: Time.zone.now)
    redirect_to @notification.notifiable
    #render json: {success: true}
  end


end
