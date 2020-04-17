class Address < ApplicationRecord
  validates :destination_family_name, presence: true
  validates :destination_first_name, presence: true
  validates :destination_furigana_family, presence: true
  validates :destination_furigana_first, presence: true
  validates :zipcode, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :house_number, presence: true
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
