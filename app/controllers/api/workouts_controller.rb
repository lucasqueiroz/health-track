module Api
  class WorkoutsController < Api::ApiController

    before_action :authenticate_user

    def index
      json_response(Workout.from_user(@authenticated_user))
    end
  end
end