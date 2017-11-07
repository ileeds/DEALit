class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def create_omni
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.id
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to root_path, flash: { danger: "Please log out of current email and log in with Brandeis email" }
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
