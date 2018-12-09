class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password'
      render :new
    end
  end

  def destroy
    if logged_in?
      log_out
      redirect_to root_path
    else
      flash[:danger] = "You're not logged in!"
      redirect_to root_path
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
