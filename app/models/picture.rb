class Picture < ActiveRecord::Base
  default_scope  { where("image_file_name IS NOT NULL")}
  belongs_to :imageable, polymorphic: true
  
  has_attached_file :image,
    :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "130x130>", :tiny => "50x50>" },
    :url => "/system/:imageable/:id/:style/:filename",
    :path => ":rails_root/public:url"
    
  validates_attachment_size  :image, less_than: 15.megabytes
end
