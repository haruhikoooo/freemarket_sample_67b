class GoodsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :category_index
  before_action :set_good, only: [:show, :edit, :update, :destroy]
  before_action :exhibitor_only, only: [:edit, :update, :destroy]

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
    set_parent_category
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
      set_parent_category
      render :new
    end
  end

  def show
  end
  
  def edit
    set_category_data(@good)
    set_parent_category
  end

  def update
    @good.category_id = nil if good_params[:category_id] == nil
    if @good.update(good_params)
      redirect_to root_path
    else
      @good.images.reset
      set_category_data(@good)
      set_parent_category
      render :edit
    end
  end

  def destroy
    redirect_to good_path(@good.id) unless current_user == @good.user
    if @good.destroy
      redirect_to user_path(current_user)
    else
      @parents = Category.roots.all
      @images = @good.images
      render :show
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

  def get_image
    @image = Image.find(params[:id])
    render json: @image
  end

  
  private
  
  def good_params
    params.require(:good).permit(:name, :explanation, :category_id, :brand, :condition_id, :prefecture_id, :derivery_day_id, :derivery_cost_id, :price, :user_id, :transaction_status_id, images_attributes: [:id, :image, :_destroy]).merge(user_id: current_user.id)
  end

  def set_good
    @good = Good.find(params[:id])
  end

  def set_parent_category
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def exhibitor_only
    redirect_to good_path(@good.id) unless current_user == @good.user
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
