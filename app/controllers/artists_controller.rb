class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show update destroy ]

  # GET /artists
  def index
    @artists = Artist.all

    render json: {data: @artists}, status: :ok
  end

  # GET /artists/1
  def show
    render json: @artist, status: :ok
  end

  # POST /artists
  def create
    puts "params #{artist_params}"
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created, location: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH /artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artists/1
  def destroy
    @artist.destroy!
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_artist
    @artist = Artist.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def artist_params
    params.permit(:name, :dob, :gender, :address, :first_release_year, :no_of_albums_released)
  end
end
