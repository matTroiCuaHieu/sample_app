module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  # rubocop:disable Rails/HelperInstanceVariable
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def logout
    session.delete :user_id
    @current_user = nil
  end
  # rubocop:enable Rails/HelperInstanceVariable
end
