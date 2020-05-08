class GoodsController < ApplicationController
  before_action :category_index

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

  def category_index
    @categories = Category.all.order("id ASC").limit(13)
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    render json: @category_children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:children_id]).children
    render json: @category_grandchildren
  end

end
