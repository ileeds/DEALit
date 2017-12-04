class HomesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_home,       only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

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
      marker.infowindow "Address: #{home.address} \n \n Rooms: #{home.total_rooms} \n\n Size: #{home.size.to_i}".gsub(/\n/, '<br/>')
      marker.json({ price: home.price, id:home.id })
    end

    @all_price_min = Home.minimum(:price).floor rescue nil
    @all_price_max = Home.maximum(:price).ceil rescue nil
    @price_min = params[:filterrific]["with_price_range"]["min"] rescue @all_price_min
    @price_max = params[:filterrific]["with_price_range"]["max"] rescue @all_price_max

    @all_total_rooms_min = Home.minimum(:total_rooms).floor rescue nil
    @all_total_rooms_max = Home.maximum(:total_rooms).ceil rescue nil
    @total_rooms_min = params[:filterrific]["with_total_rooms_range"]["min"] rescue @all_total_rooms_min
    @total_rooms_max = params[:filterrific]["with_total_rooms_range"]["max"] rescue @all_total_rooms_max

    @all_available_rooms_min = Home.minimum(:available_rooms).floor rescue nil
    @all_available_rooms_max = Home.maximum(:available_rooms).ceil rescue nil
    @available_rooms_min = params[:filterrific]["with_available_rooms_range"]["min"] rescue @all_available_rooms_min
    @available_rooms_max = params[:filterrific]["with_available_rooms_range"]["max"] rescue @all_available_rooms_max

    @all_total_bathrooms_min = Home.minimum(:total_bathrooms).floor rescue nil
    @all_total_bathrooms_max = Home.maximum(:total_bathrooms).ceil rescue nil
    @total_bathrooms_min = params[:filterrific]["with_total_bathrooms_range"]["min"] rescue @all_total_bathrooms_min
    @total_bathrooms_max = params[:filterrific]["with_total_bathrooms_range"]["max"] rescue @all_total_bathrooms_max

    @all_private_bathrooms_min = Home.minimum(:private_bathrooms).floor rescue nil
    @all_private_bathrooms_max = Home.maximum(:private_bathrooms).ceil rescue nil
    @private_bathrooms_min = params[:filterrific]["with_private_bathrooms_range"]["min"] rescue @all_private_bathrooms_min
    @private_bathrooms_max = params[:filterrific]["with_private_bathrooms_range"]["max"] rescue @all_private_bathrooms_max

    @all_driving_distance_min = Home.minimum(:driving_distance).floor rescue nil
    @all_driving_distance_max = Home.maximum(:driving_distance).ceil rescue nil
    @driving_distance_min = params[:filterrific]["with_driving_distance_range"]["min"] rescue @all_driving_distance_min
    @driving_distance_max = params[:filterrific]["with_driving_distance_range"]["max"] rescue @all_driving_distance_max

    @all_driving_duration_min = Home.minimum(:driving_duration).floor rescue nil
    @all_driving_duration_max = Home.maximum(:driving_duration).ceil rescue nil
    @driving_duration_min = params[:filterrific]["with_driving_duration_range"]["min"] rescue @all_driving_duration_min
    @driving_duration_max = params[:filterrific]["with_driving_duration_range"]["max"] rescue @all_driving_duration_max

    @all_bicycling_distance_min = Home.minimum(:bicycling_distance).floor rescue nil
    @all_bicycling_distance_max = Home.maximum(:bicycling_distance).ceil rescue nil
    @bicycling_distance_min = params[:filterrific]["with_bicycling_distance_range"]["min"] rescue @all_bicycling_distance_min
    @bicycling_distance_max = params[:filterrific]["with_bicycling_distance_range"]["max"] rescue @all_bicycling_distance_max

    @all_bicycling_duration_min = Home.minimum(:bicycling_duration).floor rescue nil
    @all_bicycling_duration_max = Home.maximum(:bicycling_duration).ceil rescue nil
    @bicycling_duration_min = params[:filterrific]["with_bicycling_duration_range"]["min"] rescue @all_bicycling_duration_min
    @bicycling_duration_max = params[:filterrific]["with_bicycling_duration_range"]["max"] rescue @all_bicycling_duration_max

    @all_transit_distance_min = Home.minimum(:transit_distance).floor rescue nil
    @all_transit_distance_max = Home.maximum(:transit_distance).ceil rescue nil
    @transit_distance_min = params[:filterrific]["with_transit_distance_range"]["min"] rescue @all_transit_distance_min
    @transit_distance_max = params[:filterrific]["with_transit_distance_range"]["max"] rescue @all_transit_distance_max

    @all_transit_duration_min = Home.minimum(:transit_duration).floor rescue nil
    @all_transit_duration_max = Home.maximum(:transit_duration).ceil rescue nil
    @transit_duration_min = params[:filterrific]["with_transit_duration_range"]["min"] rescue @all_transit_duration_min
    @transit_duration_max = params[:filterrific]["with_transit_duration_range"]["max"] rescue @all_transit_duration_max

    @all_walking_distance_min = Home.minimum(:walking_distance).floor rescue nil
    @all_walking_distance_max = Home.maximum(:walking_distance).ceil rescue nil
    @walking_distance_min = params[:filterrific]["with_walking_distance_range"]["min"] rescue @all_walking_distance_min
    @walking_distance_max = params[:filterrific]["with_walking_distance_range"]["max"] rescue @all_walking_distance_max

    @all_walking_duration_min = Home.minimum(:walking_duration).floor rescue nil
    @all_walking_duration_max = Home.maximum(:walking_duration).ceil rescue nil
    @walking_duration_min = params[:filterrific]["with_walking_duration_range"]["min"] rescue @all_walking_duration_min
    @walking_duration_max = params[:filterrific]["with_walking_duration_range"]["max"] rescue @all_walking_duration_max
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
    @home = Home.find(params[:id])
  end

  # GET /homes/1/edit
  def edit
    if @home.option.nil?
      @home.option=Option.new
    end
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)
    @home.user_id = current_user.id
    respond_to do |format|
      if @home.save
        if params[:images]
          params[:images].each do |picture|
            @home.photos.create(photo: picture)
          end
        end
        format.html { redirect_to Home.last, notice: 'Home was successfully created.' }
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
        if params[:images]
          params[:images].each do |picture|
            @home.photos.create(photo: picture)
          end
        end
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @home }
        @home.users.each do |user|
          Notification.create(recipient: user, actor: @home.user, action: "changed the #{@home.previous_changes.except(:updated_at).keys.join(', ')} of #{@home.address}", notifiable: @home)
        end
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:user_id, :gallery_id, :notification_id, :description, :photos, :address, :price, :size, :start_date, :end_date, :total_rooms, :available_rooms, :total_bathrooms, :private_bathrooms, :is_furnished, :driving_distance, :driving_duration, :bicycling_distance, :bicycling_duration, :transit_distance, :transit_duration, :walking_distance, :walking_duration, option_attributes:[:id, :size_of_house, :capacity, :free_parking, :street_parking, :deposit, :broker, :pets, :beds, :heated, :ac, :tv, :dryer, :dish_washer, :fireplace, :kitchen, :garbage_disposal, :wireless, :lock, :elevator, :pool, :gym, :wheelchair, :hot_tub, :smoking, :events, :subletting, :utilities_included, :water_price, :heat_price, :closet, :porch, :lawn, :patio, :storage, :floors, :refrigerator, :stove, :microwave, :laundry, :laundry_free, :bike, :soundproof, :intercom, :gated, :doorman, :house, :apartment])
    end

    def set_home
      @home = Home.find(params[:id])
    end

    def correct_user
      redirect_to(root_url) unless current_user.id == @home.user_id
    end

    def check
      @home.option.attributes.each do |p|
       if p[0]!="id"&&p[0]!="created_at"&&p[0]!="updated_at"&&p[0]!="home_id"&&(p[1]==true||p[1].class==Integer||p[1].class==Float||(p[0]!="id"&&p[0]!="created_at"&&p[0]!="updated_at"&&p[0]!="home_id"&&p[1].nil? == false && p[1] != false && p[1].empty? == false))
         return true
       end
      end
      return false
    end

end
