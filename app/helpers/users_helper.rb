module UsersHelper
  def redirect_logged_in_user
    redirect_to root_path if logged_in?
  end
end