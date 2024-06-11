class ApplicationController < ActionController::API
  include Authentication

  before_action :authenticate_request
  rescue_from JWT::VerificationError, JWT::DecodeError, with: :token_error
  rescue_from JWT::ExpiredSignature, with: :expired_token

end
