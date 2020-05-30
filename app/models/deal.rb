class Deal < ApplicationRecord
  belongs_to :good
  belongs_to :user
  validates :good_id, presence: true, uniqueness: true
  validates :user_id, presence: true
end
