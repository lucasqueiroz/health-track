module Api
  class HeightsController < Api::ApiController
    include ApiResponse

    before_action :authenticate_user, only: [:index, :show]
    before_action :set_height, only: [:show]

    def index
      json_response(@authenticated_user.heights)
    end

    def show
      if @height.present?
        json_response(@height)
      else
        json_not_found_response
      end
    end

    private

    def set_height
      @height = Height.find_by(id: params[:id], user: @authenticated_user)
    end
  end
end