class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  before_action :category_index, only: [:index, :new]

  def index
  end

  def new
  end

  def create
    redirect_to user_payments_path(current_user)
  end

  def destroy
    redirect_to user_payments_path(current_user)
  end

  def finish
  end

  private
  def only_current_user
    if user = User.find_by_id(params[:user_id])
      unless current_user.id == user.id
        redirect_to user_payments_path(current_user)
      end
    else
      redirect_to user_payments_path(current_user)
    end
  end
  
  def create
    @payment = payment.new(group_params)
    if @group.save
      redirect_to :root #成功の場合
    else        
      render 'new' #失敗の場合 
    end
  end

end
