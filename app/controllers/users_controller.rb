class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]
  before_action :find_user, only: [:update , :show , :destroy]

  def index 
    users = User.all
    render json: users , status: 200
  end

  def show 
    render json: @user , status: 200
  end

  def new
    render json: @user , status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user , status: 201
    else
      render json: {error: user.error.full_message} , status: 503
    end
  end

  def update
    unless @user.update(user_params)
      render json: {error: @user.error.full_message} , status: 503
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.permit(:user_name , :email , :password , :name , :role)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
