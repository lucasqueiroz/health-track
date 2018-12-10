module ApiSpecHelper
  def json
    JSON.parse(response.body)
  end
end