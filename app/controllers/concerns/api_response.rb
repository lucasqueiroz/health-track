module ApiResponse
  def json_response(object, except = [])
    render json: object, except: except
  end

  def json_error_response(object, status = :ok)
    messages = object.is_a?(String) ? [object] : object.errors.full_messages
    render json: { errors: messages }, status: status
  end

  def json_unauthorized_response
    json_error_response('User not authorized!')
  end

  def json_not_found_response
    json_error_response('Not found!', :not_found)
  end
end