module Authentication
  def current_user
    token = extract_token_from_header(request.headers['Authorization'])
    @current_user = find_user_by_token(token)
    return @current_user if @current_user.present?
    render_unauthorized unless @current_user
  end

  def extract_token_from_header(authorization_header)
    authorization_header&.split(' ')&.last
  end

  def find_user_by_token(token)
    return unless token
    decoded_token = JsonWebToken.decode(token)
    User.find_by(id: decoded_token[:user_id])
  end

  def render_unauthorized
    render json: { error: 'Please login first' }, status: :unauthorized
  end

  def expired_token
    render json: { error: 'Token expired' }, status: :forbidden
  end

  def token_error
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end