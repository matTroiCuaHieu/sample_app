class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_user, only: :show

  def index
    @users = User.page(params[:page]).per Settings.pagination
  end

  def show
    return if @user&.activated

    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "user_mailer.please_activate"
      redirect_to root_url
    else
      flash[:danger] = t "alert.error_signup"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".alert.profile_updated"
      redirect_to @user
    else
      flash[:danger] = t ".alert.profile_update_failed"
      render :edit
    end
  end

  def destroy
    if User.find_by(id: params[:id])&.destroy
      flash[:success] = t ".alert.user_deleted"
    else
      flash[:danger] = t ".alert.user_not_found"
    end

    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".alert.please_login."
    redirect_to login_url
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless @user == current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

<<<<<<< Updated upstream
    flash[:danger] = t "users.alert.user_not_found"
=======
    flash[:danger] = t "shared.user_not_found"
>>>>>>> Stashed changes
    redirect_to root_url
  end
end
