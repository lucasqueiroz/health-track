class UsersController < ApplicationController

  def index
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if logged_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created! You may now log in."
      redirect_to login_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birthday, :password, :password_confirmation)
  end

end
