module Api
  class FoodsController < Api::ApiController

    before_action :authenticate_user

    def index
      json_response(Food.from_user(@authenticated_user))
    end
  end
end