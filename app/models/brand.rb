class Brand < ApplicationRecord
  has_many   :goods
  belongs_to :category
end