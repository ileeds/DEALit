class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]
before_action :check_logged, only: [:show, :edit, :update, :destroy]
before_action :default, only: [:edit]
  # GET /options
  # GET /options.json
  def index
    @options = Option.all
  end

  # GET /options/1
  # GET /options/1.json
  def show

  end

  # GET /options/new
  def new

    @option = Option.new

    @option.home = @option.build_home

end

  # GET /options/1/edit
  def edit
  end

  # POST /options
  # POST /options.json
  def create
    @option = Option.new(option_params)
    @option.home.user_id = current_user.id

    respond_to do |format|

      if @option.valid?
        @option.save
        format.html { redirect_to @option.home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @option.home }



      else
        format.html { redirect_to :controller => 'homes', :action => 'new'  }
        format.json { render json: @option.home.errors, status: :unprocessable_entity }
      end

    end


  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    respond_to do |format|

      @option.home.user_id = current_user.id
       defaults = {"home_attributes" =>{"user_id" => current_user.id}}


      if @option.update(defaults.merge(option_params))
        format.html { redirect_to @option.home, notice: 'Option was successfully updated.' }
        format.json { render :show, status: :ok, location: @option.home }
      else
      
        format.html { redirect_to :controller => 'homes', :action => 'edit'  }
        format.json { render json: @option.home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy

    @option.destroy
    respond_to do |format|
      format.html { redirect_to options_url, notice: 'Option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end
    def check_logged
      if !current_user
        redirect_to login_path
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:size_of_house, :capacity, :free_parking, :street_parking, :deposit, :broker, :pets, :beds, :heated, :ac, :tv, :dryer, :dish_washer, :fireplace, :kitchen, :garbage_disposal, :wireless, :lock, :elevator, :pool, :gym, :wheelchair, :hot_tub, :smoking, :events, :subletting, :utilities_included, :water_price, :heat_price, :closet, :porch, :lawn, :patio, :storage, :floors, :refrigerator, :stove, :microwave, :laundry, :laundry_free, :bike, :soundproof, :intercom, :gated, :doorman, :house, :apartment, home_attributes:[:user_id, :gallery_id, :notification_id, :description, :address, :price, :size, :start_date, :end_date, :total_rooms, :available_rooms, :total_bathrooms, :private_bathrooms, :is_furnished])
    end
    def check
      @option.attributes.each do |p|
      byebug
      if p[1]==true||(p[0]!='id'&&p[1].nil? == false && p[1] != false && p[1].empty? ==false)
          return true
      end
      end

    return false
  end
  def default
    @option.home.user_id = current_user.id
  end
