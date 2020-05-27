class TransactionsController < ApplicationController
  before_action :set_good_id, only: [:new, :create]

  def new
  end

  def create
  end

  private
  
  def set_good_id
    @good = Good.find(params[:good_id])
  end
end
