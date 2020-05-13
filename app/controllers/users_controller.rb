class UsersController < ApplicationController

  def show
    user = User.find(params[:id])
    unless current_user.id == user.id
      redirect_to user_path(current_user.id)
    end
  end

end
