require 'rails_helper'

RSpec.describe Like, type: :model do
  describe "Rspec for like model" do
    it { should belong_to(:user) }
    it { should belong_to(:song) }
  end
end
