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
  end

  def destroy
  end

end
