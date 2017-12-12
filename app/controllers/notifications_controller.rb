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

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    respond_to do |format|
      format.html { head :no_content }
      format.js {render "destroy", :locals => {:id => params[:id]} }
    end
    push_count(Notification.actives(current_user.id).to_a.select{|notification| notification.read_at==nil}.length,current_user.id.to_s)
  end

private
  def push_count(count,user)
    Pusher.trigger('count-'+user,
                  'notification_event', count: count)
  end

end
