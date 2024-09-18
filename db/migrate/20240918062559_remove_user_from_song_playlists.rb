class RemoveUserFromSongPlaylists < ActiveRecord::Migration[7.1]
  def change
    remove_reference :song_playlists, :user, null: false, foreign_key: true
  end
end
