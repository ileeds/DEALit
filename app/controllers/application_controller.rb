class ApplicationController < ActionController::Base
  before_action :start_filterrific
  protect_from_forgery with: :exception
  include SessionsHelper

  def start_filterrific
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
  end
end
