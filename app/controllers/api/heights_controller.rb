module Api
  class HeightsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_height, only: [:show, :update, :destroy]

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
      if @height.present?
        if @height.update(height_params)
          json_response(@height)
        else
          json_error_response(@height)
        end
      else
        json_not_found_response
      end
    end

    def destroy
      if @height.present?
        @height.destroy
        head :no_content
      else
        json_not_found_response
      end
    end

    private

    def set_height
      @height = Height.find_by(id: params[:id], user: @authenticated_user)
    end

    def height_params
      params.require(:height).permit(:measurement, :measured_at)
    end
  end
end