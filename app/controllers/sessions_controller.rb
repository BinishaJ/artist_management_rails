class SessionsController < ApplicationController

  skip_before_action :authenticate_request

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        token: JsonWebToken.encode({user_id: user.id}),
        email: user.email,
      }, status: :ok
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:email, :password)
  end
end