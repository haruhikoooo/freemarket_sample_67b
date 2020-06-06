class BuysController < ApplicationController
  before_action :category_index
  def index
    @categories = Category.all
end
end
