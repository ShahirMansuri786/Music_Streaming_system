class LikesController < ApplicationController
  before_action :find_like , only: [:show , :update, :destroy]

  def index 
    likes = Like.all
    render json: likes , status: 200
  end

  def show 
    render json: @like , status: 200
  end

  def create
    like = Like.new(like_params)
    if like.save
      render json: like , status: 201
    else
      render json: {error: like.errors.full_message} , status: 503
    end
  end

  def update
    if @like.update(like_params)
      render json: @like , status: 200
    else
      render json: {error: @like.error.full_message} , status: 503
    end
  end

  def destroy
    if @like.destroy
      render json: @like , status: 200
    else
      render json: {error: @like.error.full_message} , status: 503
    end
  end

  private

  def like_params
    params.permit(:user_id , :song_id)
  end

  def find_like
    @like = Like.find(params[:id])
  end

end
