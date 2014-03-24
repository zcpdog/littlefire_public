class Picture < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true, touch: true
  validates :image, presence: true
  
  if Rails.env.production?
    mount_uploader :image, ProductionImageUploader
  else
    mount_uploader :image, ImageUploader
  end
  
  rails_admin do
    edit do
      field :image
    end
    list do
      field :id
      field :image
      field :imageable
      field :created_at
      field :updated_at
    end
  end
  #https://github.com/carrierwaveuploader/carrierwave/wiki/How-to%3A-Validate-attachment-file-size
  # validates :image, :presence => true, 
#     :file_size => { :maximum => 1.megabytes.to_i }
  
end
