class SongsController < ApplicationController
  before_action :find_song, only: [:update , :show , :destroy]

  def index 
    songs = User.all
    render json: songs , status: 200
  end

  def show 
    render json: @song , status: 200
  end

  def create
    if User.find(params[:user_id]).role == "admin"
      song = Song.new(song_params)
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
    unless @song.update(song_params)
      render json: {error: @song.error.full_message} , status: 503
    end
  end

  def destroy
    @song.destroy
  end

  private

  def song_params
    params.permit(:name , :user_id, :category_id , :singer_name)
  end

  def find_song
    @song = Song.find(params[:id])
  end
end
