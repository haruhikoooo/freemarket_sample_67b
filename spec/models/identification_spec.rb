require 'rails_helper'

describe Identification do

  # 1. family_name、first_name、furigana_family、furigana_first、birthdayが存在すれば登録できること
  it "is valid with a nickname, email, password, password_confirmationamily_name, first_name, furigana_family, furigana_first, birthday" do
    user = build(:identification)
    expect(user).to be_valid
  end

  describe '#create_identification' do
    # 2. family_nameが空では登録できないこと
    it "is invalid without a family_name" do
      user = build(:identification, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include(I18n.t('errors.messages.blank'))
    end

    # 3. first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user = build(:identification, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include(I18n.t('errors.messages.blank'))
    end

    # 4. furigana_familyが空では登録できないこと
    it "is invalid without a furigana_family" do
      user = build(:identification, furigana_family: nil)
      user.valid?
      expect(user.errors[:furigana_family]).to include(I18n.t('errors.messages.blank'))
    end

    # 5. furigana_firstが空では登録できないこと
    it "is invalid without a furigana_first" do
      user = build(:identification, furigana_first: nil)
      user.valid?
      expect(user.errors[:furigana_first]).to include(I18n.t('errors.messages.blank'))
    end

    # 6. birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user = build(:identification, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include(I18n.t('errors.messages.blank'))
    end

    # 7. family_nameが全角でないと登録できないこと
    it "is invalid family_name" do
      user = build(:identification, family_name:"hankaku" )
      user.valid?
      expect(user.errors[:family_name]).to include("は不正な値です")
    end

    # 8. first_nameが全角でないと登録できないこと
    it "is invalid first_name" do
      user = build(:identification, first_name:"hankaku" )
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end

    # 9. furigana_familyが全角でないと登録できないこと
    it "is invalid furigana_family" do
      user = build(:identification, furigana_family:"hankaku" )
      user.valid?
      expect(user.errors[:furigana_family]).to include("は不正な値です")
    end

    # 10. furigana_firstが全角でないと登録できないこと
    it "is invalid furigana_first" do
      user = build(:identification, furigana_first:"hankaku" )
      user.valid?
      expect(user.errors[:furigana_first]).to include("は不正な値です")
    end
  end
end
