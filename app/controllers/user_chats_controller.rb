class UserChatsController < ApplicationController
  before_action :set_user_chat, only: [:show, :edit, :update, :destroy]

  # GET /user_chats
  # GET /user_chats.json
  def index
    @user_chats = UserChat.all
  end

  # GET /user_chats/1
  # GET /user_chats/1.json
  def show
  end

  # GET /user_chats/new
  def new
    @user_chat = UserChat.new
  end

  # GET /user_chats/1/edit
  def edit
  end

  # POST /user_chats
  # POST /user_chats.json
  def create
    @user_chat = UserChat.new(user_chat_params)

    respond_to do |format|
      if @user_chat.save
        format.html { redirect_to @user_chat, notice: 'User chat was successfully created.' }
        format.json { render :show, status: :created, location: @user_chat }
      else
        format.html { render :new }
        format.json { render json: @user_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_chats/1
  # PATCH/PUT /user_chats/1.json
  def update
    respond_to do |format|
      if @user_chat.update(user_chat_params)
        format.html { redirect_to @user_chat, notice: 'User chat was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_chat }
      else
        format.html { render :edit }
        format.json { render json: @user_chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_chats/1
  # DELETE /user_chats/1.json
  def destroy
    @user_chat.destroy
    respond_to do |format|
      format.html { redirect_to user_chats_url, notice: 'User chat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_chat
      @user_chat = UserChat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_chat_params
      params.require(:user_chat).permit(:user_id, :chat_id, :read)
    end
end
