class HomeStepsController < ApplicationController
  include Wicked::Wizard
  steps :rooms, :amenities, :calendar

  def show
    @home = Home.find(params[:home_id])
    render_wizard
  end

  def update
    @home = Home.find(params[:home_id])
    params[:home][:status] = step.to_s
    params[:home][:status] = 'active' if step == steps.last
    @home.update_attributes(home_params)
    if params[:images]
      params[:images].each do |picture|
        @home.photos.create(image: picture)
      end
    end

    if @step==:calendar && @home.valid?
      redirect_to "/homes/"+@home.id.to_s+"/photos/new"
      @home.users.each do |user|
        if !@home.previous_changes.blank?
          @notification = Notification.create(recipient: user, actor: @home.user, action: "changed the #{@home.previous_changes.except(:updated_at).keys.join(', ').humanize} of #{@home.address}", notifiable: @home)
          sync_new @notification
          push_count(Notification.actives(user.id).to_a.select{|notification| notification.read_at==nil}.length,user.id.to_s)
        end
      end
    else
      @home.users.each do |user|
        if !@home.previous_changes.blank?
          @notification = Notification.create(recipient: user, actor: @home.user, action: "changed the #{@home.previous_changes.except(:updated_at).keys.join(', ').humanize} of #{@home.address}", notifiable: @home)
          sync_new @notification
          push_count(Notification.actives(user.id).to_a.select{|notification| notification.read_at==nil}.length,user.id.to_s)
        end
      end
      render_wizard(@home, {}, { home_id: @home.id })
    end
  end

  def add_photos
    respond_to do |format|
    if params[:images]
      params[:images].each do |picture|
        @home.photos.create(image: picture)
      end
    end
    format.js { render :file => "/homes/photo.js.erb" }
  end
  end

  def create
    @home = Home.create(home_params)
    if params[:images]
      params[:images].each do |picture|
        @home.photos.create(image: picture)
      end
    end
    redirect_to wizard_path(steps.first, :home_id => @home.id)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:description, :title, :photos, :address, :price, :start_date, :end_date, :total_rooms, :available_rooms, :available_beds, :total_bathrooms, :private_bathrooms, :is_furnished, :entire_home, :capacity, :distance, :driving_duration, :bicycling_duration, :transit_duration, :walking_duration, :status, option_attributes:[:id, :free_parking, :street_parking, :deposit, :broker, :pets, :heated, :ac, :tv, :dryer, :dish_washer, :fireplace, :kitchen, :garbage_disposal, :wireless, :lock, :elevator, :pool, :gym, :wheelchair, :hot_tub, :smoking, :events, :subletting, :utilities_included, :water_price, :heat_price, :closet, :porch, :lawn, :patio, :storage, :floors, :refrigerator, :stove, :microwave, :laundry, :laundry_free, :bike, :soundproof, :intercom, :gated, :doorman, :house, :apartment])
    end

    def push_count(count,user)
      Pusher.trigger('count-'+user,
                    'notification_event', count: count)
    end
end
