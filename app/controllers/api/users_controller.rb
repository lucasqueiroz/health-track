module Api
  class UsersController < Api::ApiController
    include ApiResponse

    before_action :authenticate_user, only: [:index, :show, :update, :destroy]
    before_action :set_user, only: [:show, :update, :destroy]
    wrap_parameters :user, include: [:name, :email, :birthday, :password, :password_confirmation]

    def index
      json_response(User.all)
    end

    def show
      json_response(@user)
    end

    def create
      @user = User.new(user_params)
      if @user.save
        json_response(@user)
      else
        json_error_response(@user)
      end
    end

    def update
      if @user.update(user_params)
        json_response(@user)
      else
        json_error_response(@user)
      end
    end

    def destroy
      @user.destroy
      head :no_content
    end

    private

    def set_user
      user = User.find(params[:id])
      verify_ownership(user)
      @user = user
    end

    def user_params
      params.require(:user).permit(:name, :email, :birthday, :password, :password_confirmation)
    end

  end
end