class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show update destroy get_music ]
  before_action :total_artists, only: %i[index count]

  load_and_authorize_resource

  # GET /artists
  def index
    page = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
    limit = (params[:limit].to_i <= 0) ? 10 : params[:limit].to_i
    offset = (page - 1) * limit

    @artists = Artist.limit(limit).offset(offset)

    render json: {data: @artists, total: @total_artists}, status: :ok
  end

  # GET artists/count
  def count
    render json: {data: @total_artists}, status: :ok
  end


  # GET /artists/1
  def show
    render json: @artist, status: :ok
  end

  # GET /artists/1/music
  def get_music
    @musics = Music.where(artist_id: params[:id])

    render json: {data: @musics}, status: :ok
  end

  # POST /artists
  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      render json: @artist, status: :created, location: @artist
    else
      render json: {error: @artist.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH /artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: {error: @artist.errors.full_messages}, status: :unprocessable_entity
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

  def total_artists
    @total_artists = Artist.all.count
  end
end
