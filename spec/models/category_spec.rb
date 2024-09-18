require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Rspec for category" do
    it { should have_many(:songs)}
  end
end
