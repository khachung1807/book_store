class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :show, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :index, :update, :add_employee]

  def index
    @users = User.paginate page: params[:page], per_page: 10
  end

  def new
    @user = User.new
  end

  def create
    if logged_in? && current_user.admin?
      create_by_admin
    else
      create_by_user
    end
  end

  def show
    redirect_to root_url && return unless @user.activated == true
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = t ".delete_success"
    redirect_to users_url
  end

  private
  def create_by_user
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "activation_mesage"
      redirect_to root_url
    else
      flash[:danger] = t ".create_failed"
      render :new
    end
  end

  def create_by_admin
    @user = User.new admin_params
    if @user.save
      flash[:success] = t "welcome"
      redirect_to users_path
    else
      flash[:danger] = t ".create_failed"
      render :add_employee
    end
  end

  def admin_user
    return if current_user.admin?
    redirect_to root_url
    flash[:danger] = t ".not_admin"
  end

  def user_params
    params.require(:user).permit :name, :gender, :birthday, :address,
      :phone_number, :email, :password, :password_confirmation
  end

  def admin_params
    params.require(:user).permit :name, :gender, :birthday, :address,
      :phone_number, :email, :password, :password_confirmation,
      :user_type
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t "log_msg"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url if @user
    !@user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
