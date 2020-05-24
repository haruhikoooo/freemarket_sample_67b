class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :category_index, only: [:show, :index_likes]

  def show
    if user = User.find_by_id(params[:id])
      unless current_user.id == user.id
        redirect_to user_path(current_user.id)
      end
    else
      redirect_to user_path(current_user.id)
    end
  end

end
