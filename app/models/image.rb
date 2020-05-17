class Image < ApplicationRecord
  belongs_to :good
  mount_uploader :image, ImageUploader
end
