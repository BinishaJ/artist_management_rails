class MusicsController < ApplicationController
  before_action :set_music, only: %i[ show update destroy ]
  before_action :total_music, only: %i[index count]

  load_and_authorize_resource

  # GET /musics
  def index
    @musics = Music.all
    render json: {data: @musics, total: @total_music}, status: :ok
  end

  # GET musics/count
  def count
    render json: {data: @total_music}, status: :ok
  end

  # GET /musics/1
  def show
    render json: @music, status: :ok
  end

  # POST /musics
  def create
    p "User #{@current_user.id}"
    @music = Music.new(music_params)

    if @music.save
      render json: @music, status: :created, location: @music
    else
      render json: {error: @music.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /musics/1
  def update
    if @music.update(music_params)
      render json: @music
    else
      render json: {error: @music.errors.full_messages}, status: :unprocessable_entity
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

  def total_music
    @total_music = Music.all.count
  end
end
