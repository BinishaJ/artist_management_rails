class MusicsController < ApplicationController
  before_action :set_music, only: %i[ show update destroy ]

  # GET /musics
  def index
    total_musics = Music.all.count

    page = (params[:page].to_i <= 0) ? 1 : params[:page].to_i
    limit = (params[:limit].to_i <= 0) ? 10 : params[:limit].to_i
    offset = (page - 1) * limit

    @musics = Music.limit(limit).offset(offset)

    render json: {data: @musics, total: total_musics}, status: :ok
  end

  # GET /musics/1
  def show
    render json: @music, status: :ok
  end

  # POST /musics
  def create
    @music = Music.new(music_params)

    if @music.save
      render json: @music, status: :created, location: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /musics/1
  def update
    if @music.update(music_params)
      render json: @music
    else
      render json: @music.errors, status: :unprocessable_entity
    end
  end

  # DELETE /musics/1
  def destroy
    @music.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def music_params
      params.permit(:artist_id, :title, :album_name, :genre)
    end
end
