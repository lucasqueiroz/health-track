module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
    p session[:user_id]
  end

  def current_user
    user_id = session[:user_id]
    p user_id
    @current_user ||= User.find_by(id: user_id) if user_id
  end

  def logged_in?
    !current_user.nil?
  end

end
