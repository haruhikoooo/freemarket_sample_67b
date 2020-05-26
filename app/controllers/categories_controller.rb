class CategoriesController < ApplicationController
  before_action :category_index
  
  def show
    @category = Category.find(params[:id])
    if @category.has_children?
      @goods = Good.where(category_id: @category.descendant_ids)
    else
      @goods = Good.where(category_id: @category.id)
    end
  end
end
