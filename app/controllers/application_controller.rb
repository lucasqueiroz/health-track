class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def check_user
    redirect_user unless logged_in?
  end

  def redirect_user
    flash[:danger] = "You must be logged in to do this!"
    redirect_to login_path
  end
end
