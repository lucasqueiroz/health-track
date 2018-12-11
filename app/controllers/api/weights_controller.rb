module Api
  class WeightsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_weight, only: [:show, :update]

    def index
      json_response(Weight.from_user(@authenticated_user))
    end

    def show
      json_response(@weight)
    end

    def create
      weight = Weight.new(weight_params)
      weight.user_id = @authenticated_user.id
      if weight.save
        json_response(weight)
      else
        json_error_response(weight)
      end
    end

    def update
      if @weight.update(weight_params)
        json_response(@weight)
      else
        json_error_response(@weight)
      end
    end

    private

    def set_weight
      @weight = Weight.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @weight.present?
    end

    def weight_params
      params.require(:weight).permit(:measurement, :measured_at)
    end
  end
end