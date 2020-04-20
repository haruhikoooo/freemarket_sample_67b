class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :family_name, presence: true
  validates :family_name,  format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name, presence: true
  validates :first_name,  format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :furigana_family, presence: true
  validates :furigana_family,  format: { with: /\A[ぁ-んァ-ヶー－]+\z/}
  validates :furigana_first, presence: true
  validates :furigana_first,  format: { with: /\A[ぁ-んァ-ヶー－]+\z/}
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
