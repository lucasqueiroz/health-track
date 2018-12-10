module ApiResponse
  def json_response(object)
    render json: object
  end
end