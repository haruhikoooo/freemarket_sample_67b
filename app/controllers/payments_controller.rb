class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  before_action :category_index, only: [:index, :new]

  require "payjp"
  before_action :set_payment
  


  def index
    Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to new_user_payment_path
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      )
      @payment = Payment.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @payment.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def new
    card = Payment.where(user_id: current_user.id)
    redirect_to card_path(current_user.id) if card.exists?
  end

  def create
    redirect_to user_payments_path(current_user)
  end

  def destroy
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to user_payments_path(current_user)
  end

  def  #Cardのデータpayjpに送り情報を取り出す
    card = Card.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_card_path 
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_PRIVATE_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
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

  def set_payment
    @payment = Payment.where(user_id: current_user.id).first if Payment.where(user_id: current_user.id).present?
  end
