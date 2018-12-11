module Api
  class HeightsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_height, only: [:show, :update, :destroy]

    def index
      json_response(@authenticated_user.heights)
    end

    def show
      json_response(@height)
    end

    def create
      height = Height.new(height_params)
      height.user_id = @authenticated_user.id
      if height.save
        json_response(height)
      else
        json_error_response(height)
      end
    end

    def update
      if @height.update(height_params)
        json_response(@height)
      else
        json_error_response(@height)
      end
    end

    def destroy
      @height.destroy
      head :no_content
    end

    private

    def set_height
      @height = Height.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @height.present?
    end

    def height_params
      params.require(:height).permit(:measurement, :measured_at)
    end
  end
end