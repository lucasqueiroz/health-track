module Api
  class UsersController < Api::ApiController
    def index
      render json: User.all, status: :ok
    end
  end
end