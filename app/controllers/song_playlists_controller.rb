class SongPlaylistsController < ApplicationController
  before_action :find_song_playlist , only: [:show , :update, :destroy]

  def index 
    song_playlists = SongPlaylist.all
    render json: song_playlists , status: 200
  end

  def show 
    render json: @song_playlist , status: 200
  end

  def create
    song_playlist = SongPlaylist.new(song_playlist_params)
    if song_playlist.save
      render json: song_playlist , status: 201
    else
      render json: {error: song_playlist.errors.full_message} , status: 503
    end
  end

  def update
    if @song_playlist.update(song_playlist_params)
      render json: @song_playlist , status: 200
    else
      render json: {error: @song_playlist.error.full_message} , status: 503
    end
  end

  def destroy
    if @song_playlist.destroy
      render json: @song_playlist , status: 200
    else
      render json: {error: @song_playlist.error.full_message} , status: 503
    end
  end

  private

  def song_playlist_params
    params.permit(:playlist_id , :song_id)
  end

  def find_song_playlist
    @song_playlist = SongPlaylist.find(params[:id])
  end
end
