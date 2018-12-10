module Api
  class UsersController < Api::ApiController
    before_action :set_user, only: [:show]
    def index
      render json: User.all
    end

    def show
      render json: @user
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

  end
end