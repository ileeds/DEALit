class HomesController < ApplicationController
  before_action :set_home, except: [:index, :new, :create]

  # GET /homes
  # GET /homes.json
  def index
    # support filtering
    @filterrific = initialize_filterrific(
      Home,
      params[:filterrific],
      # options for different filters go here
      select_options: {
        sorted_by: Home.options_for_sorted_by,
        with_is_furnished: Home.options_for_furnished
      }
    ) or return

    @homes = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end

    @hash = Gmaps4rails.build_markers(@homes) do |home, marker|
      marker.lat home.latitude
      marker.lng home.longitude
      marker.infowindow home.address
      marker.json({ price: home.price })
    end

    @all_price_min = Home.minimum(:price).floor rescue nil
    @all_price_max = Home.maximum(:price).ceil rescue nil
    @price_min = params[:filterrific]["with_price_range"]["min_price"] rescue @all_price_min
    @price_max = params[:filterrific]["with_price_range"]["max_price"] rescue @all_price_max

    @all_total_rooms_min = Home.minimum(:total_rooms).floor rescue nil
    @all_total_rooms_max = Home.maximum(:total_rooms).ceil rescue nil
    @total_rooms_min = params[:filterrific]["with_total_rooms_range"]["min_rooms"] rescue @all_total_rooms_min
    @total_rooms_max = params[:filterrific]["with_total_rooms_range"]["max_rooms"] rescue @all_total_rooms_max

    @all_available_rooms_min = Home.minimum(:available_rooms).floor rescue nil
    @all_available_rooms_max = Home.maximum(:available_rooms).ceil rescue nil
    @available_rooms_min = params[:filterrific]["with_available_rooms_range"]["min_rooms"] rescue @all_available_rooms_min
    @available_rooms_max = params[:filterrific]["with_available_rooms_range"]["max_rooms"] rescue @all_available_rooms_max

    @all_total_bathrooms_min = Home.minimum(:total_bathrooms).floor rescue nil
    @all_total_bathrooms_max = Home.maximum(:total_bathrooms).ceil rescue nil
    @total_bathrooms_min = params[:filterrific]["with_total_bathrooms_range"]["min_rooms"] rescue @all_total_bathrooms_min
    @total_bathrooms_max = params[:filterrific]["with_total_bathrooms_range"]["max_rooms"] rescue @all_total_bathrooms_max

    @all_private_bathrooms_min = Home.minimum(:private_bathrooms).floor rescue nil
    @all_private_bathrooms_max = Home.maximum(:private_bathrooms).ceil rescue nil
    @private_bathrooms_min = params[:filterrific]["with_private_bathrooms_range"]["min_rooms"] rescue @all_private_bathrooms_min
    @private_bathrooms_max = params[:filterrific]["with_private_bathrooms_range"]["max_rooms"] rescue @all_private_bathrooms_max
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @home }
      else
        format.html { render :new }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
      else
        format.html { render :edit }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:user_id, :gallery_id, :notification_id, :option_id, :description, :address, :price, :size, :start_date, :end_date, :total_rooms, :available_rooms, :total_bathrooms, :private_bathrooms, :is_furnished)
    end
end
