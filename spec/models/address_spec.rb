require 'rails_helper'

describe Address do
  describe '#create' do
    # 1. destination_family_nameとdestination_first_name,destination_furigana_family,destination_furigana_first,zipcode,prefecture_id,city,house_numberが存在すれば登録できること
    it "is valid with a destination_family_name,destination_first_name,destination_furigana_family,destination_furigana_first,zipcode,prefecture_id,city,house_number" do
      address = build(:address)
      expect(address).to be_valid
    end

    # 2. destination_family_nameが空では登録できないこと
    it "is invalid without a destination_family_name" do
      address = build(:address, destination_family_name: nil)
      address.valid?
      expect(address.errors[:destination_family_name]).to include(I18n.t('errors.messages.blank'))
    end

    # 3. destination_first_nameが空では登録できないこと
    it "is invalid without a destination_first_name" do
      address = build(:address, destination_first_name: nil)
      address.valid?
      expect(address.errors[:destination_first_name]).to include(I18n.t('errors.messages.blank'))
    end

    # 4. destination_furigana_familyが空では登録できないこと
    it "is invalid without a destination_furigana_family" do
      address = build(:address, destination_furigana_family: nil)
      address.valid?
      expect(address.errors[:destination_furigana_family]).to include(I18n.t('errors.messages.blank'))
    end

    # 5. destination_furigana_firstが空では登録できないこと
    it "is invalid without a destination_furigana_first" do
      address = build(:address, destination_furigana_first: nil)
      address.valid?
      expect(address.errors[:destination_furigana_first]).to include(I18n.t('errors.messages.blank'))
    end

    # 6. zipcodeが空では登録できないこと
    it "is invalid without a zipcode" do
      address = build(:address, zipcode: nil)
      address.valid?
      expect(address.errors[:zipcode]).to include(I18n.t('errors.messages.blank'))
    end

    # 7. prefecture_idが空では登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include(I18n.t('errors.messages.blank'))
    end

    # 8. cityが空では登録できないこと
    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include(I18n.t('errors.messages.blank'))
    end

    # 9. house_numberが空では登録できないこと
    it "is invalid without a house_number" do
      address = build(:address, house_number: nil)
      address.valid?
      expect(address.errors[:house_number]).to include(I18n.t('errors.messages.blank'))
    end
  end
end
