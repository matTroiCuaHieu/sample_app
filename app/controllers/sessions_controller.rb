class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to user
    else
      flash[:danger] = t "sessions.new.error_email_password_invalid"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
