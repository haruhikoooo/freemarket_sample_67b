class Comment < ApplicationRecord
  belongs_to :good
  belongs_to :user

  validates :comment, presence: true
end
