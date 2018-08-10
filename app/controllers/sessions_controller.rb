class SessionsController < ApplicationController
  before_action :fetch_current_user, only: [:create]
  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        log_in @user
        remember_me
        redirect_back_or @user
      else
        message = t "activation_message1"
        message += t "activation_message2"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t ".error_signin"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def fetch_current_user
    @user = User.find_by email: params[:session][:email].downcase
  end

  def remember_me
    params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
  end
end
