require 'rails_helper'

describe User do
  describe '#create' do
    # 1. nicknameとemail、password、password_confirmation、family_name、first_name、furigana_family、furigana_first、birthdayが存在すれば登録できること
    it "is valid with a nickname, email, password, password_confirmationamily_name, first_name, furigana_family, furigana_first, birthday" do
      user = build(:user)
      expect(user).to be_valid
    end

    # 2. nicknameが空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include(I18n.t('errors.messages.blank'))
    end

    # 3. emailが空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    # 4. passwordが空では登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include(I18n.t('errors.messages.blank'))
    end

    # 5. family_nameが空では登録できないこと
    it "is invalid without a family_name" do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include(I18n.t('errors.messages.blank'))
    end

    # 6. first_nameが空では登録できないこと
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include(I18n.t('errors.messages.blank'))
    end

    # 7. furigana_familyが空では登録できないこと
    it "is invalid without a furigana_family" do
      user = build(:user, furigana_family: nil)
      user.valid?
      expect(user.errors[:furigana_family]).to include(I18n.t('errors.messages.blank'))
    end

    # 8. furigana_firstが空では登録できないこと
    it "is invalid without a furigana_first" do
      user = build(:user, furigana_first: nil)
      user.valid?
      expect(user.errors[:furigana_first]).to include(I18n.t('errors.messages.blank'))
    end

    # 9. birthdayが空では登録できないこと
    it "is invalid without a birthday" do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include(I18n.t('errors.messages.blank'))
    end

    # 10. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # 11. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("既に登録されています")
    end

    # 12. passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than ７ characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # 13. passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than ６ characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("7文字以上にしてください")
    end

    # 14. family_nameが全角でないと登録できないこと
    it "is invalid family_name" do
      user = build(:user, family_name:"hankaku" )
      user.valid?
      expect(user.errors[:family_name]).to include("全角で入力してください")
    end

    # 15. first_nameが全角でないと登録できないこと
    it "is invalid family_name" do
      user = build(:user, first_name:"hankaku" )
      user.valid?
      expect(user.errors[:first_name]).to include("全角で入力してください")
    end

    # 16. furigana_familyが全角でないと登録できないこと
    it "is invalid furigana_family" do
      user = build(:user, furigana_family:"hankaku" )
      user.valid?
      expect(user.errors[:furigana_family]).to include("全角で入力してください")
    end

    # 17. furigana_firstが全角でないと登録できないこと
    it "is invalid furigana_first" do
      user = build(:user, furigana_first:"hankaku" )
      user.valid?
      expect(user.errors[:furigana_first]).to include("全角で入力してください")
    end
  end
end
