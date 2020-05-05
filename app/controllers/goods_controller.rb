class GoodsController < ApplicationController

  def toppage
    @goods = Good.where(transaction_status_id: "1").order(created_at: "DESC").first(3)
  end

  def index
    @goods = Good.all.order(created_at: "DESC")
  end

  def new
  end

  def show
    @good = Good.find(params[:id])
  end

  def destroy
  end

end
