class ApplicationController < ActionController::API

  before_action :authenticate_request
  rescue_from JWT::VerificationError, JWT::DecodeError, with: :token_error
  rescue_from JWT::ExpiredSignature, with: :expired_token

  private
  def authenticate_request
    token = extract_token_from_header(request.headers['Authorization'])
    @current_user = find_user_by_token(token)
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
