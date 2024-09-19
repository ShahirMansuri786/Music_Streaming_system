class SongsController < ApplicationController
  # include JwtToken
  before_action :find_song, only: [:update , :show , :destroy]
  before_action :current_user

  def index 
    songs = Song.all
    render json: songs , status: 200
  end

  def show 
    render json: @song , status: 200
  end

  def create
    if @current_user.role == "admin"
      song = @current_user.songs.new(song_params)
      if song.save
        render json: song , status: 201
      else
        render json: {error: song.error.full_message} , status: 503
      end
    else
      render json: {message: 'Admin can add the song only'} , status: 503
    end
  end

  def update
    if @song.update(song_params)
      render json: @song , status: 200
    else
      render json: {error: @song.error.full_message} , status: 503
    end
  end

  def destroy
    @song.destroy
    render json: @song , status: 200
  end

  private

  def song_params
    params.permit(:name, :category_id, :singer_name)
  end

  def find_song
    @song = Song.find(params[:id])
  end
end
