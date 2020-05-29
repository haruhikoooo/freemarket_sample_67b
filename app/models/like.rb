class Like < ApplicationRecord
  validates :user_id, presence: true
  validates :good_id, presence: true
  belongs_to :user
  belongs_to :good
end
