require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Rspec for user" do
    it { should have_many(:likes) }
    it { should have_one(:playlist) }
    it { should have_many(:songs)}
  end
end
