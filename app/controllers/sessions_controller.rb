class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    authenticated user
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def authenticated user
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash[:danger] = t "sessions.new.error_email_password_invalid"
      render :new
    end
  end

  def check_activated user
    if user.activated?
      log_in user
      params[:session][:remember_me] == Settings.boolean.true ? remember(user) : forget(user)
      flash[:success] = t "sessions.new.login_successfully"
      redirect_back_or user
    else
      flash[:warning] = t "sessions.alert.account_not_activated"
      redirect_to root_url
    end
  end
end
