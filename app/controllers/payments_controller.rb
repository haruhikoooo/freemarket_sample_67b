class PaymentsController < ApplicationController

  def new
    payment = Payment.where(user_id: current_user.id)
    redirect_to new_user_payment_path(current_user.id) if payment.exists?
  end

  def create #payjpとCardのデータベース作成
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to new_user_payment_path
    else
      customer = Payjp::Customer.create(
        payment: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @payment = Payment.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @payment.save
        redirect_to root_path(current_user.id)
      else
        redirect_to new_user_payment_path
      end
    end
  end

  def destroy #Payjpとpaymentsデータベースを削除
    payment = Payment.find_by(user_id: current_user.id)
    if payment.blank?
    else
      Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
      customer = Payjp::Customer.retrieve(payment.customer_id)
      customer.delete
      payment.delete
    end
      redirect_to new_user_payment_path
  end

  def show #paymentsのデータpayjpに送り情報を取り出す
    @payment = Payment.find_by(user_id: current_user.id)
    if @payment.blank?
      redirect_to new_user_payment_path 
    else
      #payjpと通信するためのkeyをセットしました
      Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
      customer = Payjp::Customer.retrieve(@payment.user_id)
      @default_card_information = customer.cards.retrieve(@payment.card_number)
    end
  end
end