require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe "Rspec for Playlist" do
    it { should belong_to(:user) }
    # it { should have_many(:songs)}
  end
end
