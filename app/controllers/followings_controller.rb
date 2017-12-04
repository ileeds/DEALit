class FollowingsController < ApplicationController
  before_action :set_following, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:new, :create]

  # GET /followings
  # GET /followings.json
  def index
    @followings = Following.all
  end

  # GET /followings/1
  # GET /followings/1.json
  def show
  end

  # GET /followings/new
  def new
    @following = Following.new
  end

  # GET /followings/1/edit
  def edit
  end

  # POST /followings
  # POST /followings.json
  def create
    @following = Following.new(home_id: following_params[:home_id], user_id: current_user.id)
    respond_to do |format|
      if(Following.exists?(home_id: following_params[:home_id], user_id: current_user.id))
        flash[:notice] = 'You are already following this home.'
        format.html { redirect_to root_url }
      elsif(@following.save)
        flash[:notice] = 'Successfully followed'
        format.html { redirect_to root_url }
      else
        format.html { redirect_to root_url, notice: "Unsuccessful" }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /followings/1
  # PATCH/PUT /followings/1.json
  def update
    respond_to do |format|
      if @following.update(following_params)
        format.html { redirect_to @following, notice: 'Following was successfully updated.' }
        format.json { render :show, status: :ok, location: @following }
      else
        format.html { render :edit }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /followings/1
  # DELETE /followings/1.json
  def destroy
    @following.destroy
    respond_to do |format|
      format.html { redirect_to followings_url, notice: 'Following was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def following_params
      params.require(:following).permit(:home_id)
    end
end
