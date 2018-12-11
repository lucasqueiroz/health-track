module Api
  class WeightsController < Api::ApiController

    before_action :authenticate_user

    def index
      json_response(Weight.from_user(@authenticated_user))
    end
  end
end