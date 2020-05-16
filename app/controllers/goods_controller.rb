class GoodsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!, only: [:new]
  before_action :category_index
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]

  def index
    @goods = Good.where(transaction_status_id: "1").last(3) 
  end

  def new
    @good = Good.new
    @good.images.new
    @parents = Category.all.order("id ASC").limit(13)
      @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  


  def create
    @good = Good.new(good_params)
    @good.transaction_status_id = 1
    if @good.save
      redirect_to root_path
    else
      @good.images.reset
      @good.images.new
      @parents = Category.all.order("id ASC").limit(13)
        @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
      render :new
    end
  end


  def show
    @good = Good.find(params[:id])
  end

  def edit
    @good = Good.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

  def category_index
    @categories = Category.order("id ASC").limit(13)
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
    render json: @category_children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:children_id]).children
    render json: @category_grandchildren
  end


  private
  
  def good_params
    params.require(:good).permit(:name, :explanation, :category_id, :brand, :condition_id, :prefecture_id, :derivery_day_id, :derivery_cost_id, :price, :user_id, :transaction_status_id, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end
  
end