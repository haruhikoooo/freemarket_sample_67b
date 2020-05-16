class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :category_index
  protect_from_forgery with: :exception
  # before_action :move_to_index, except: [:index, :show]
  
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

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end


  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :first_name, :furigana_family, :furigana_first, :birthday])
  end
  


end