module Api
  class WorkoutsController < Api::ApiController

    before_action :authenticate_user
    before_action :set_workout, only: [:show, :update]

    def index
      json_response(Workout.from_user(@authenticated_user))
    end

    def show
      json_response(@workout)
    end

    def create
      workout = Workout.new(workout_params)
      workout.user_id = @authenticated_user.id
      if workout.save
        json_response(workout)
      else
        json_error_response(workout)
      end
    end

    def update
      if @workout.update(workout_params)
        json_response(@workout)
      else
        json_error_response(@workout)
      end
    end

    private

    def set_workout
      @workout = Workout.find_by(id: params[:id], user_id: @authenticated_user.id)
      json_not_found_response unless @workout.present?
    end

    def workout_params
      params.require(:workout).permit(:name, :calories, :occurred_at)
    end
  end
end