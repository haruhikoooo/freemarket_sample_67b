class GoodsController < ApplicationController

  def index
    @goods = Good.where(transaction_status_id: "1").last(3) 
  end

  def new
    @good = Good.new
    @good.images.new
  end

  def creat
    @good = Good.new(good_params)
    if @good.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  
  private
  
  def good_params
    params.require(:good).permit(:name, images_attributes: [:image])
  end
end