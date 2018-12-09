class ApplicationController < ActionController::Base
  include SessionsHelper

  def check_user
    if current_user.nil?
      flash[:danger] = "You must be logged in to do this!"
      redirect_to login_path
    end
  end
end
