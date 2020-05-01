class GoodsController < ApplicationController

  def index
    @goods = Good.where(transaction_status_id: "1").last(3) 
  end

  def new
  end
  def show
  end
end
