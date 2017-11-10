class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def create_omni
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.id
      log_in @user
      redirect_to root_path
    else
      redirect_to root_path, flash: { danger: "Please log out of current email and log in with Brandeis email" }
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
