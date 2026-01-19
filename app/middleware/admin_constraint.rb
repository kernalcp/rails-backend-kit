class AdminConstraint
  def matches?(request)
    header = request.get_header('HTTP_AUTHORIZATION')
    return false unless header

    token = header.split(' ').last
    decoded = JsonWebToken.decode(token)
    return false unless decoded

    user = User.find_by(id: decoded[:user_id])
    user&.admin?
  rescue
    false
  end
end
