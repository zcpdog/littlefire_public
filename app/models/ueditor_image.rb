class UeditorImage < ActiveRecord::Base
  validates :image, presence: true
  mount_uploader :image, UeditorImageUploader
end
