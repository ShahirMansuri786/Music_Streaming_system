class CategoriesController < ApplicationController
  before_action :find_category, only: [:update , :show , :destroy]

  def index 
    categories = Category.all
    render json: categories , status: 200
  end

  def show 
    render json: @category , status: 200
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: category , status: 201
    else
      render json: {error: category.error.full_message} , status: 503
    end
  end

  def update
    unless @category.update(category_params)
      render json: {error: @category.error.full_message} , status: 503
    end
  end

  def destroy
    @category.destroy
  end

  private

  def category_params
    params.permit(:category_name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end
