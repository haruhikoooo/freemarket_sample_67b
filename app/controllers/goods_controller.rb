class GoodsController < ApplicationController
  before_action :category_index

  def index 
  end

  def new
  end
  def show
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
