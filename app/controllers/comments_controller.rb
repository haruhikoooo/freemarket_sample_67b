class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    comment = Comment.new(comment_params)
    @good = Good.find(params[:good_id])
    redirect_to good_path(@good.id) and return
    if comment.save
      redirect_to good_path(@good.id)
    else
      render "goods/#{@good.id}"
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, good_id: params[:good_id])
  end

end
