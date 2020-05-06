class Good < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :transaction_status
end
