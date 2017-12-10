class NotificationsController < ApplicationController
  before_action :logged_in_user
  #enable_sync only: [:create, :update, :destroy]

  def index
    @notifications = Notification.where(recipient: current_user).limit(10).order(created_at: :desc)
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(read_at: Time.zone.now)
    if @notification.notifiable.class == Mailboxer::Conversation
      redirect_to conversation_path(@notification.notifiable_id)
    else
      redirect_to @notification.notifiable
    end
    #render json: {success: true}
  end


end
