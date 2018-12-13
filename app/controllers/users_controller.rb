class UsersController < ApplicationController
  include UsersHelper

  before_action :redirect_logged_in_user, only: [:new]
  before_action :redirect_logged_out_user, only: [:show], unless: :logged_in?
  before_action :set_user, only: [:show]

  def new
    @user = User.new
  end

  def show
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

  def set_user
    @user = User.find(params[:id])
  end
end
