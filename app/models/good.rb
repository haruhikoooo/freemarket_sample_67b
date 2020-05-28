class Good < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images, dependent: :destroy
  has_many :likes
  has_many :users_likes, through: :likes, source: :user, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :transaction_status
  belongs_to_active_hash :size
  belongs_to_active_hash :condition
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :derivery_cost
  belongs_to_active_hash :derivery_day

  validates_associated :images
  validates :images,
    presence: { message: "を投稿してください"}

  validates :name,
    presence: true,
    length: { maximum: 40, message: "文字数オーバーです", allow_blank: true}

  validates :explanation,
    presence: true,
    length: { maximum: 1000, message: "文字数オーバーです", allow_blank: true}
  
  validates :category_id,
    presence: { message: "まで入力してください"}

  validates :condition,
    presence: { message: "を選択してください"}

  validates :derivery_cost,
    presence: { message: "を選択してください"}

  validates :prefecture_id,
    presence: { message: "を選択してください"}

  validates :derivery_day,
    presence: { message: "を選択してください"}

  validates :price,
    presence: true,
    numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は¥300 ~ ¥9,999,999です", allow_blank: true}
end
