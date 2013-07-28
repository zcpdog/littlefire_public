class Picture < ActiveRecord::Base
  #default_scope  { where("attachment_file_name NOT NULL")}
  belongs_to :imageable, polymorphic: true
  
  has_attached_file :image,
    :url => "/system/:imageable/:id/:style/:filename",
    :path => ":rails_root/public:url"
  
  validates_attachment_size  :image, less_than: 15.megabytes
end
