require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "Rspec for song" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:likes)}
    # it { should have_many(:playlists)}
  end
end
