require 'rails_helper'
include JwtToken

RSpec.describe LikesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:song) { FactoryBot.create(:song , user: user) }
  let(:like) { FactoryBot.create(:like , song: song , user: user) }

  before do
    token = jwt_encode({user_id: user.id})
    request.headers['Authorization'] = "Bearer #{token}"
  end
	
	describe 'LikesController#index' do
		it 'get all likes' do
			process :index, method: :get 
			expect(response).to have_http_status(:success)
		end
	end

	describe "LikesController#show" do
		it "show playlist" do
			process :show, method: :get ,  params: { id: like.id}
			expect(response).to have_http_status(:success)
			expect(assigns(:like)).to eq(like)
		end
	end

  describe "LikesController#delete" do
		it "like#delete" do
			process :destroy, method: :delete ,  params:{ id: like.id }
			expect(Like.exists?(like.id)).to be_falsey
		end
	end

  describe "LikesController#create" do
    it "creates like" do
      process :create, method: :post ,  params: { user_id: user.id , song_id: song.id}
      expect(Like.last.user_id).to eq(user.id)
    end
  end
end