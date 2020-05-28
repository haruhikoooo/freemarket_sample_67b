class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    Like.create(user_id: current_user.id, good_id: "#{params[:good_id]}")
    @good = Good.find(params[:good_id])
    render json: { id: @good.id, likes: @good.users_likes.length }
  end

  def destroy
    Like.find_by(user_id: current_user.id, good_id: "#{params[:good_id]}").destroy
    @good = Good.find(params[:good_id])
    render json: { id: @good.id, likes: @good.users_likes.length }
  end

  def show
    if user = User.find_by_id(params[:id])
      unless current_user.id == user.id
        redirect_to like_path(current_user.id)
      end
    else
      redirect_to like_path(current_user.id)
    end
    if @goods = current_user.goods_likes
    end
  end

end
