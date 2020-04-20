class PaymentsController < ApplicationController

  def index
  end

  def new
  end

  def create
    redirect_to payments_path
  end

  def destroy
    redirect_to payments_path
  end
end
