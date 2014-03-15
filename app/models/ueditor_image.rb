class UeditorImage < ActiveRecord::Base
  validates :image, presence: true
  if Rails.env.production?
    mount_uploader :image, ProductionImageUploader
  else
    mount_uploader :image, ImageUploader
  end
end
