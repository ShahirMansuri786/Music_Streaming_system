require 'rails_helper'
include JwtToken

RSpec.describe UsersController, type: :controller do
	let(:user) { FactoryBot.create(:user) }
  
  before do
    token = jwt_encode({user_id: user.id})
    request.headers['Authorization'] = "Bearer #{token}"
  end
	
	describe 'UsersController#index' do
		it 'assigns all users to users' do
			process :index, method: :get 
			expect(response).to have_http_status(:success)
		end
	end

	describe "UsersController#show" do
		it "UsersController#show" do
			# user = FactoryBot.create(:user)
			process :show, method: :get ,  params: { id: user.id}
			expect(response).to have_http_status(:success)
			expect(assigns(:user)).to eq(user)
		end
	end

	describe "UsersController#update" do
		it "updates user" do
			user = FactoryBot.create(:user)
			process :update, method: :patch , params: { id: user.id, name: "Updated" , user_name: "Shahir" } 
			user.reload
			expect(user.name).to eq("Updated")
		end  
  end

  describe "UsersController#delete" do
		it "user#delete" do
			process :destroy, method: :delete ,  params:{ id: user.id }
			expect(User.exists?(user.id)).to be_falsey
		end
	end

  describe "UsersController#create" do
    it "creates a new user" do
      process :create, method: :post ,  params: {name: "Nice" , user_name: "xyz", email: "xyz123@gmail.com", password: 12345678 , role: "admin" } 
      expect(User.last.name).to eq("Nice")
    end
  end
end
