require 'rails_helper'

describe User do
  describe '#create' do
    # 1. nicknameとemail、password、password_confirmationが存在すれば登録できること
    it "is valid with a nickname, email, password, password_confirmation" do
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

    # 5. passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    # 6. 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("既に登録されています")
    end

    # 7. passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than ７ characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # 8. passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than ６ characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("7文字以上にしてください")
    end

    before do
      Rails.application.env_config['omniauth.auth'] = github_mock
    end
    # 認可サーバーから帰ってきた情報と同じuidが既に存在する場合
    context 'is invalid with a duplicate uid' do
    before do
      User.create( nickname:"フリマ太郎", email:"ttt@gmail.com", password: "00000000",password_confirmation: "00000000", provider: 'github', uid: '12345')
      end
      example 'is invalid' do
        expect(User.create( nickname:"フリマ太郎", email:"ttt@gmail.com", password: "00000000",password_confirmation: "00000000", provider: 'github', uid: '12345').errors[:uid]).to include('はすでに存在します')
      end         
    end
  end

  describe '#find_for_github_auth' do
    # 既に同じproviderでかつ同じuidのレコードがある場合はuserはtrueとなる
    it "is user true whith provider & uid " do
      User.create( nickname:"フリマ太郎", email:"ttt@gmail.com", password: "00000000",password_confirmation: "00000000", provider: 'github', uid: '12345')
      user = User.find_by(provider: "github", uid: "12345")
      expect(user).to be_truthy
    end

     # 同じproviderでかつ同じuidのレコードがない場合はuserはfalseとなる
     it "is user false whithout provider & uid " do
      user = User.find_by(provider: "github", uid: "12345")
      expect(user).to be_falsey
    end
  
  end
  

end
