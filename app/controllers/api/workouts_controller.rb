module Api
  class WorkoutsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_workout, only: [:show]

    def index
      json_response(Workout.from_user(@authenticated_user))
    end

    def show
      json_response(@workout)
    end

    private

    def set_workout
      @workout = Workout.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @workout.present?
    end
  end
end