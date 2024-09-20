require 'rails_helper'
include JwtToken

RSpec.describe CategoriesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:category) { FactoryBot.create(:category) }
  
  before do
    token = jwt_encode({user_id: user.id})
    request.headers['Authorization'] = "Bearer #{token}"
  end
	
	describe 'CategoriesController#index' do
		it 'get all categories' do
			process :index, method: :get 
			expect(response).to have_http_status(:success)
		end
	end

	describe "CategoriesController#show" do
		it "show category" do
			process :show, method: :get ,  params: { id: category.id}
			expect(response).to have_http_status(:success)
			expect(assigns(:category)).to eq(category)
		end
	end

  describe "CategoriesController#update" do
		it "updates category" do
			category = FactoryBot.create(:category)
			process :update, method: :patch , params: { id: category.id , category_name: "Updated" } 
			category.reload
			expect(category.category_name).to eq("Updated")
		end  
  end

  describe "CategoriesController#delete" do
		it "category#delete" do
			process :destroy, method: :delete ,  params:{ id: category.id }
			expect(Category.exists?(category.id)).to be_falsey
		end
	end

  describe "CategoriesController#create" do
    it "creates category" do
      process :create, method: :post ,  params: { category_name: "new category"}
      expect(Category.last.category_name).to eq("new category")
    end
  end
end
