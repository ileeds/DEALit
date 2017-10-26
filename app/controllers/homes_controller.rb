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

    @min = @homes.minimum(:price).floor rescue nil
    @max = @homes.maximum(:price).ceil rescue nil
    @total_min = Home.minimum(:price).floor rescue nil
    @total_max = Home.maximum(:price).ceil rescue nil
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
