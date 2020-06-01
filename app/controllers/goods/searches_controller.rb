class Goods::SearchesController < ApplicationController
  def index
    @goods = Good.search(params[:keyword])
  end
end
