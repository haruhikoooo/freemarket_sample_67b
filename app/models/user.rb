class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]

  def self.find_for_github_auth(auth, signed_in_resource = nil)  
  where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|  
    user.nickname = auth.info.name  
    user.email = User.dummy_email(auth)  
    user.password = Devise.friendly_token[0, 20]
    user.family_name = "山田"
    user.first_name = "太郎"
    user.furigana_family = "ヤマダ"
    user.furigana_first = "タロウ"
    user.birthday = "2000-05-01"
    end  
  end  

  def self.dummy_email(auth)  
  "#{auth.uid}-#{auth.provider}@example.com"  
  end  

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :family_name, presence: true
  validates :family_name,  format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name, presence: true
  validates :first_name,  format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :furigana_family, presence: true
  validates :furigana_family,  format: { with: /\A[ァ-ヶー－]+\z/}
  validates :furigana_first, presence: true
  validates :furigana_first,  format: { with: /\A[ァ-ヶー－]+\z/}
  validates :birthday, presence: true
  has_one :payment, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :likes
  has_many :goods_likes, through: :likes, source: :good, dependent: :destroy
  has_many :comments
  has_many :goods_comments, through: :comments, source: :good, dependent: :destroy
  has_many :trannsactions
  has_many :goods_transactions, through: :transactions, source: :good, dependent: :destroy
end
