module Api
  class UsersController < Api::ApiController
    include ApiResponse

    before_action :set_user, only: [:show, :update, :destroy]

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
        render json: { errors: @user.errors.full_messages }
      end
    end

    def update
      if @user.update(user_params)
        json_response(@user)
      else
        render json: { errors: @user.errors.full_messages }
      end
    end

    def destroy
      @user.destroy
      head :no_content
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