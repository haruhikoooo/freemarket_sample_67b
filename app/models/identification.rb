class Identification < ApplicationRecord
  validates :family_name, presence: true
  validates :family_name,  format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :first_name, presence: true
  validates :first_name,  format: { with: /\A[ぁ-んァ-ン一-龥]/}
  validates :furigana_family, presence: true
  validates :furigana_family,  format: { with: /\A[ァ-ヶー－]+\z/}
  validates :furigana_first, presence: true
  validates :furigana_first,  format: { with: /\A[ァ-ヶー－]+\z/}
  validates :birthday, presence: true
  belongs_to :user, optional: true
end
