class DealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_good_id

  def new
    if @good.transaction_status_id != 1 || @good.user_id == current_user.id
      redirect_to good_path(@good.id)
    end
  end

  def create
    @payment = Payment.find_by(user_id: current_user.id)
    if @payment.blank?
      redirect_to user_payments_path(current_user.id)
    else
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
      Payjp::Charge.create(
      amount: @good.price,
      customer: @payment.customer_id,
      currency: 'jpy',
      )
      @deal = Deal.new
      @deal.good_id = @good.id
      @deal.user_id = current_user.id
      @good.transaction_status_id = 2
      if @good.valid? && @deal.valid?
        @good.save
        @deal.save
        redirect_to good_deal_path(@good.id, @deal.id)
      else
        render :new
      end
    end
  end

  def show
    @deal = Deal.find(params[:id])
    redirect_to good_path(@good.id) if @deal.user_id != current_user.id
  end

  private
  
  def set_good_id
    @good = Good.find(params[:good_id])
  end
end
