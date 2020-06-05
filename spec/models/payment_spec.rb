require 'rails_helper'

describe Payment do
  describe '#create' do
    # 1. card_idとcustomer_idが存在すれば登録できること
    it "is valid with a card_id, customer_id" do
      payment = build(:payment)
      expect(payment).to be_valid
    end

    # 2. card_idが空では登録できないこと
    it "is invalid without a card_id" do
      payment = build(:payment, card_id: nil)
      payment.valid?
      expect(payment.errors[:card_id]).to include(I18n.t('errors.messages.blank'))
    end

    # 3. customer_idが空では登録できないこと
    it "is invalid without a customer_id" do
      payment = build(:payment, customer_id: nil)
      payment.valid?
      expect(payment.errors[:customer_id]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
