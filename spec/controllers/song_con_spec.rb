require 'rails_helper'
include JwtToken

RSpec.describe SongsController, type: :controller do
	let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  let(:song) { FactoryBot.create(:song , user: user , category: category) }
  
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

	describe "SongsController#show" do
		it "show song" do
			# user = FactoryBot.create(:user)
			process :show, method: :get ,  params: { id: song.id}
			expect(response).to have_http_status(:success)
			expect(assigns(:song)).to eq(song)
		end
	end

	describe "SongsController#update" do
		it "updates song" do
			process :update, method: :patch , params: { id: song.id, name: "Updated" } 
			song.reload
			expect(song.name).to eq("Updated")
		end  
  end

  describe "SongsController#delete" do
		it "song#delete" do
			process :destroy, method: :delete ,  params:{ id: song.id }
			expect(Song.exists?(song.id)).to be_falsey
		end
	end

  describe "SongsController#create" do
    it "creates song" do
      process :create, method: :post ,  params: { name: "Tum ho" , user_id: user.id, category_id: category.id , singer_name: "arijit" } 
      expect(Song.last.name).to eq("Tum ho")
    end
  end
end
