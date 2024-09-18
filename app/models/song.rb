class Song < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :playlists , through: :song_playlist
  has_many :likes
end
