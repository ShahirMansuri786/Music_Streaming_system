class AddPlaylistToSongPlaylist < ActiveRecord::Migration[7.1]
  def change
    add_reference :song_playlists, :playlist, null: false, foreign_key: true
  end
end
