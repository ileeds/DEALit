class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    receipt = current_user.reply_to_conversation(@conversation, params[:body])
    #recipient = User.find(@conversation.participants.select { |jj| jj.id != current_user.id }[:id])
    if @conversation.participants.last == current_user
      recipient = @conversation.participants.first
    else
      recipient = @conversation.participants.last
    end
    Notification.create(recipient: recipient, actor: current_user, action: "replied "+params[:body], notifiable: @conversation)
    redirect_to conversation_path(receipt.conversation)
  end

  private

    def set_conversation
      @conversation = current_user.mailbox.conversations.find(params[:conversation_id])
    end
end
