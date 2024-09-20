require 'rails_helper'
include JwtToken

RSpec.describe PlaylistsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:playlist) { FactoryBot.create(:playlist , user: user) }

  before do
    token = jwt_encode({user_id: user.id})
    request.headers['Authorization'] = "Bearer #{token}"
  end
	
	describe 'PlaylistsController#index' do
		it 'get all playlists' do
			process :index, method: :get 
			expect(response).to have_http_status(:success)
		end
	end

	describe "PlaylistsController#show" do
		it "show playlist" do
			process :show, method: :get ,  params: { id: playlist.id}
			expect(response).to have_http_status(:success)
			expect(assigns(:playlist)).to eq(playlist)
		end
	end

  describe "PlaylistsController#delete" do
		it "playlist#delete" do
			process :destroy, method: :delete ,  params:{ id: playlist.id }
			expect(Playlist.exists?(playlist.id)).to be_falsey
		end
	end

  describe "PlaylistsController#create" do
    it "creates playlist" do
      process :create, method: :post ,  params: { user_id: user.id, name: "my_playlist" }
      expect(Playlist.last.name).to eq("my_playlist")
    end
  end
end