class GoodsController < ApplicationController

  def index 
  end

  def new
  end
  def show
    @good = Good.find(params[:id])
  end
end
