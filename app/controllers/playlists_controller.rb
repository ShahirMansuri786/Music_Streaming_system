class PlaylistsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_playlist , only: [:show , :update, :destroy]

  def index 
    @playlists = Playlist.all
    render json: @playlists , status: 200
  end

  def show 
    render json: @playlist , status: 200
  end

  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      render json: playlist , status: 201
    else
      render json: {error: playlist.errors.full_message} , status: 503
    end
  end

  def update
    if @playlist.update(playlist_params)
      render json: @playlist , status: 200
    else
      render json: {error: @playlist.error.full_message} , status: 503
    end
  end

  def destroy
    if @playlist.destroy
      render json: @playlist , status: 200
    else
      render json: {error: @playlist.error.full_message} , status: 503
    end
  end

  private

  def playlist_params
    params.permit(:user_id, :name)
  end

  def find_playlist
    @playlist = Playlist.find(params[:id])
  end
end
