module Api
  class FoodsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_food, only: [:show, :update, :destroy]

    def index
      json_response(Food.from_user(@authenticated_user))
    end

    def show
      json_response(@food)
    end

    def create
      food = Food.new(food_params)
      food.user_id = @authenticated_user.id
      if food.save
        json_response(food)
      else
        json_error_response(food)
      end
    end

    def update
      if @food.update(food_params)
        json_response(@food)
      else
        json_error_response(@food)
      end
    end

    def destroy
      @food.destroy
      head :no_content
    end

    private

    def set_food
      @food = Food.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @food.present?
    end

    def food_params
      params.require(:food).permit(:name, :calories, :occurred_at)
    end
  end
end