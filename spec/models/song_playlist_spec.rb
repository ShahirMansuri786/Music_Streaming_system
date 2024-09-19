require 'rails_helper'

RSpec.describe SongPlaylist, type: :model do
  describe "Rspec for song_playlist model" do
    it { should belong_to(:playlist) }
    it { should belong_to(:song) }
  end
end
