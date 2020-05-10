class Identification < ApplicationRecord
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :furigana_family, presence: true
  validates :furigana_first, presence: true
  validates :birthday, presence: true
  validates :prefecture_id, presence: true
  belongs_to :user, optional: true
end
