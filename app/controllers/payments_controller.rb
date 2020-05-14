class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user

  def index
  end

  def new
  end

  def create
    redirect_to user_payments_path(current_user)
  end

  def destroy
    redirect_to user_payments_path(current_user)
  end

  private
  def only_current_user
    if user = User.find_by_id(params[:user_id])
      unless current_user.id == user.id
        redirect_to user_payments_path(current_user)
      end
    else
      redirect_to user_payments_path(current_user)
    end
  end

end
