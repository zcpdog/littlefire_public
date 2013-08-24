class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  #validates :imageable_id, presence: true
  #validates :imageable_type, presence: true
  validates :image, presence: true
  
  if Rails.env.production?
    mount_uploader :image, ProductionImageUploader
  else
    mount_uploader :image, ImageUploader
  end
  
  #https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Validate-attachment-file-size
  # validates :image, :presence => true, 
#     :file_size => { :maximum => 1.megabytes.to_i }
  
end
