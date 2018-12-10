module Api
  class UsersController < Api::ApiController
    before_action :set_user, only: [:show]

    def index
      render json: User.all
    end

    def show
      render json: @user
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
      else
        render json: { errors: @user.errors.full_messages }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :birthday, :password, :password_confirmation)
    end

  end
end