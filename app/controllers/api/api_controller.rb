module Api
  class ApiController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ApiAuthentication, ApiResponse

    after_action :invalidate_user

    @authenticated_user = nil

    def authenticate_user
      authenticate_with_http_basic do |email, password|
        @authenticated_user = authenticate(email, password)
      end
      json_unauthorized_response unless @authenticated_user
    end

    def invalidate_user
      @authenticated_user = nil
    end

    def verify_ownership(user)
      json_unauthorized_response unless user == @authenticated_user
    end
  end
end