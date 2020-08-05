class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "shared.welcome_to_the_sample_app"
      redirect_to @user
    else
      flash[:danger] = t "shared.error_signup"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
