module Api
  class FoodsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_food, only: [:show]

    def index
      json_response(Food.from_user(@authenticated_user))
    end

    def show
      json_response(@food)
    end

    private

    def set_food
      @food = Food.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @food.present?
    end
  end
end