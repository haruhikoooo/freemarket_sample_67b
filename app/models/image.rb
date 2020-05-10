class Image < ApplicationRecord
  belongs_to :good
  mount_uploader :image_url, ImageUploader
end
