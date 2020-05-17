require 'rails_helper'

describe Good do
  describe '#create' do
  # 全ての必須項目

    it "全ての必須項目が入力されている場合出品できる" do
      good = build(:good)
      expect(good).to be_valid
    end

  # 商品名について

    it "nameが40文字以下である場合は登録できること" do
      good = build(:good, name: "a" * 40)
      expect(good).to be_valid
    end

    it "nameが41文字以上である場合は登録できないこと" do
      good = build(:good, name: "a" * 41)
      good.valid?
      expect(good.errors[:name]).to include("文字数オーバーです")
    end

  # 商品説明について

    it "explanationが1000文字以下である場合は登録できること" do
      good = build(:good, explanation: "a" * 1000)
      expect(good).to be_valid
    end

    it "explanationが1001文字以上である場合は登録できないこと" do
      good = build(:good, explanation: "a" * 1001)
      good.valid?
      expect(good.errors[:explanation]).to include("文字数オーバーです")
    end

  # カテゴリーについて

    it "category_idがない場合は登録できないこと" do
      good = build(:good_category)
      good.valid?
      expect(good.errors[:category_id]).to include("まで入力してください")
    end

  # 商品の状態について
  
    it "conditionがない場合は登録できないこと" do
      good = build(:good, condition: nil)
      good.valid?
      expect(good.errors[:condition]).to include("を選択してください")
    end
    
  # 送料の負担について
    
    it "derivery_costがない場合は登録できないこと" do
      good = build(:good, derivery_cost: nil)
      good.valid?
      expect(good.errors[:derivery_cost]).to include("を選択してください")
    end
    
  # 発送元の地域について
    
    it "prefecture_idがない場合は登録できないこと" do
      good = build(:good, prefecture_id: "")
      good.valid?
      expect(good.errors[:prefecture_id]).to include("を選択してください")
    end
  
  # 発送までの日数について
    
    it "derivery_day_idがない場合は登録できないこと" do
      good = build(:good, derivery_day: nil)
      good.valid?
      expect(good.errors[:derivery_day]).to include("を選択してください")
    end
    
  # 販売価格について

    it "priceがない場合は登録できないこと" do
      good = build(:good, price: "")
      good.valid?
      expect(good.errors[:price]).to include("を入力してください")
    end

    it "priceが¥299以下である場合は登録できないこと" do
      good = build(:good, price: 299)
      good.valid?
      expect(good.errors[:price]).to include("は¥300 ~ ¥9,999,999です")
    end

    it "priceが¥300以上である場合は登録できること" do
      good = build(:good, price: 300)
      expect(good).to be_valid
    end

    it "priceが¥10,000,000以上である場合は登録できないこと" do
      good = build(:good, price: 10000000)
      good.valid?
      expect(good.errors[:price]).to include("は¥300 ~ ¥9,999,999です")
    end

    it "priceが¥9,999,999以下である場合は登録できること" do
      good = build(:good, price: 9999999)
      expect(good).to be_valid
    end

  end
end