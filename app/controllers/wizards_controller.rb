class WizardsController < ApplicationController
  before_action :load_home_wizard, except: %i(validate_step)

  def validate_step
    current_step = params[:current_step]

    @home_wizard = wizard_home_for_step(current_step)
    @home_wizard.home.attributes = home_wizard_params
    session[:home_attributes] = @home_wizard.home.attributes

    if @home_wizard.valid?
      next_step = wizard_home_next_step(current_step)
      @home_wizard.home.user_id = current_user.id and create and return unless next_step

      redirect_to action: next_step
    else
      render_allowed_partial current_step
    end
  end

  def create
    if @home_wizard.home.save
      session[:home_attributes] = nil
      redirect_to root_path, notice: 'Home succesfully created!'
    else
      redirect_to({ action: Wizard::Home::STEPS.first }, alert: 'There were a problem when creating the home.')
    end
  end

  private

    def load_home_wizard
      @home_wizard = wizard_home_for_step(action_name)
    end

    def wizard_home_next_step(step)
      Wizard::Home::STEPS[Wizard::Home::STEPS.index(step) + 1]
    end

    def wizard_home_for_step(step)
      raise InvalidStep unless step.in?(Wizard::Home::STEPS)

      "Wizard::Home::#{step.camelize}".constantize.new(session[:home_attributes])
    end

    def home_wizard_params
      params.require(:home_wizard).permit(:description, :photos, :address, :price, :size, :start_date, :end_date, :total_rooms, :available_rooms, :total_bathrooms, :private_bathrooms, :is_furnished, option_attributes:[:id, :size_of_house, :capacity, :free_parking, :street_parking, :deposit, :broker, :pets, :beds, :heated, :ac, :tv, :dryer, :dish_washer, :fireplace, :kitchen, :garbage_disposal, :wireless, :lock, :elevator, :pool, :gym, :wheelchair, :hot_tub, :smoking, :events, :subletting, :utilities_included, :water_price, :heat_price, :closet, :porch, :lawn, :patio, :storage, :floors, :refrigerator, :stove, :microwave, :laundry, :laundry_free, :bike, :soundproof, :intercom, :gated, :doorman, :house, :apartment])
    end

    def render_allowed_partial name
      if %w(step1 step2 step3 step4).include? name
        @allowed_partial = name
      else
        raise StandardError, "unexpected partial request: #{params[:partial]}"
      end
    end

    class InvalidStep < StandardError; end
end
