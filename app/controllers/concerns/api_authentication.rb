module ApiAuthentication
  def authenticate(email, password)
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
  end
end