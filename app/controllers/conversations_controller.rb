class ConversationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create]

  def index
    @conversations = current_user.mailbox.conversations
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @recipient = User.find(params[:recipient_id])
    @home_address = params[:home_address]
  end

  def create
    recipient = User.find(params[:user_id])
    receipt = current_user.send_message(recipient, params[:body], params[:subject])
    @conversation = receipt.conversation
    Notification.create(recipient: recipient, actor: current_user, action: "initiated a chat", notifiable: @conversation)
    redirect_to conversation_path(receipt.conversation)
  end
end
