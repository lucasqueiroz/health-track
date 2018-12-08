class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.new
  end

  def new
    @user = User.new
  end

end
