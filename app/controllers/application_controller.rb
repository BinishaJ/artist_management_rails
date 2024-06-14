class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include Authentication

  before_action :current_user

  rescue_from JWT::VerificationError, JWT::DecodeError, with: :token_error
  rescue_from JWT::ExpiredSignature, with: :expired_token

  rescue_from CanCan::AccessDenied, with: :access_denied

  private
  def access_denied
    render json: { error: 'Access Denied' }, status: :unauthorized
  end
end
