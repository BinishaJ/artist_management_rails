class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  before_action :total_users, only: %i[index count]

  load_and_authorize_resource

  # GET /users
  def index
    page = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
    limit = (params[:limit].to_i <= 0) ? 10 : params[:limit].to_i
    offset = (page - 1) * limit

    @users = User.limit(limit).offset(offset)

    render json: {data: @users, total: @total_users}, status: :ok
  end

  # GET users/count
  def count
    render json: {data: @total_users}, status: :ok
  end


  # GET /users/1
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: {error: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :phone, :dob, :gender, :address, :role_id)
    end

  def total_users
    @total_users = User.all.count
  end
end
