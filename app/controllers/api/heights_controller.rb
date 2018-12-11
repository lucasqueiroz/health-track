module Api
  class HeightsController < Api::ApiController
    include ApiResponse

    before_action :authenticate_user, only: [:index]

    def index
      json_response(@authenticated_user.heights)
    end
  end
end