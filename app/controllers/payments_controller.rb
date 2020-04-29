class PaymentsController < ApplicationController

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
end
