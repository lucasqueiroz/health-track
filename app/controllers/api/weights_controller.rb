module Api
  class WeightsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_weight, only: [:show]

    def index
      json_response(Weight.from_user(@authenticated_user))
    end

    def show
      json_response(@weight)
    end

    private

    def set_weight
      @weight = Weight.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @weight.present?
    end
  end
end