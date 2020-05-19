class GoodsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :category_index
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]

  def toppage
    @goods = Good.where(transaction_status_id: "1").order(created_at: "DESC").first(3)
  end

  def index
    @goods = Good.order(created_at: "DESC")
  end

  def new
    @good = Good.new
    @good.images.new
    set_category_data(@good)
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
      set_category_data(@good)
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

  def destroy
    good = Good.find(params[:id])
    good.destroy
    redirect_to user_path(current_user)
  end

  def edit
    @good = Good.find(params[:id])
    set_category_data(@good)
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
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
    params.require(:good).permit(:name, :explanation, :category_id, :brand, :condition_id, :prefecture_id, :derivery_day_id, :derivery_cost_id, :price, :user_id, :transaction_status_id, image_attributes: [:id, :image]).merge(user_id: current_user.id)
  end

  def set_category  
    @category_parent_array = Category.where(ancestry: nil)
  end
  
  def set_category_data(good)
    if good.category.nil?
      @first_category_id = "---"
      @first_category_name = "---"
      @second_category_id = "---"
      @second_category_name = "---"
      @third_category_id = "---"
      @third_category_name = "---"
    else
      @first_category_id = good.category.root.id
      @first_category_name = good.category.root.name
      @second_category_id = good.category.parent.id
      @second_category_name = good.category.parent.name
      @third_category_id = good.category.id
      @third_category_name = good.category.name
    end
  end
end
