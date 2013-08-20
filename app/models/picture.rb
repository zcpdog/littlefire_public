class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  if Rails.env == "production"
    mount_uploader :image, ProductionImageUploader
  else
    mount_uploader :image, ImageUploader
  end
  
  # validates :image, :presence => true, 
#     :file_size => { :maximum => 1.megabytes.to_i }
  
end
