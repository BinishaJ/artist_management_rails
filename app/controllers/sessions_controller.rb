class SessionsController < ApplicationController
  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {data: user}, status: :ok
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end
end