require 'rails_helper'
include JwtToken

RSpec.describe SongPlaylistsController, type: :controller do
	
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:playlist) { FactoryBot.create(:playlist , user: user) }
  let(:song) { FactoryBot.create(:song , user: user , category: category) }
  let(:song_playlist) { FactoryBot.create(:song_playlist , playlist: playlist , song: song) }
  
  before do
    token = jwt_encode({user_id: user.id})
    request.headers['Authorization'] = "Bearer #{token}"
  end
	
	describe 'SongsController#index' do
		it 'get all songs' do
			process :index, method: :get 
			expect(response).to have_http_status(:success)
		end
	end

	describe "SongPlaylistsController#show" do
		it "show SongPlaylists" do
			# user = FactoryBot.create(:user)
			process :show, method: :get ,  params: { id: song_playlist.id}
			expect(response).to have_http_status(:success)
			expect(assigns(:song_playlist)).to eq(song_playlist)
		end
	end

  describe "SongPlaylistsController#delete" do
		it "song_playlist#delete" do
			process :destroy, method: :delete ,  params:{ id: song_playlist.id }
			expect(SongPlaylist.exists?(song_playlist.id)).to be_falsey
		end
	end

  describe "SongPlaylistsController#create" do
    it "creates song_playlist" do
      process :create, method: :post ,  params: { playlist_id_id: playlist.id, song_id: song.id }
      expect(SongPlaylist.last.playlist_id).to eq(playlist.id)
    end
  end
end