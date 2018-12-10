module ApiResponse
  def json_response(object)
    render json: object
  end

  def json_error_response(object)
    render json: { errors: object.errors.full_messages }
  end
end