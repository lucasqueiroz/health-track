module ApiSpecHelper
  def json
    JSON.parse(response.body)
  end

  def basic_auth(email, password)
    ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end