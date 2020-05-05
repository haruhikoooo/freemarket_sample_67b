class Good < ApplicationRecord
  has_many :images, dependent: :destroy
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :transaction_status
end
