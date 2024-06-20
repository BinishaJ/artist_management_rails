class SessionsController < ApplicationController

  skip_before_action :current_user

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: {
        token: JsonWebToken.encode({user_id: user.id}),
        email: user.email,
        role_id: user.role_id
      }, status: :ok
    else
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    end
  end

  # POST /register
  def register
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.permit(:first_name, :last_name, :email, :password, :phone, :dob, :gender, :address, :role_id)
  end

end