class Picture < ActiveRecord::Base
  #default_scope  { where("attachment_file_name NOT NULL")}
  belongs_to :imageable, polymorphic: true
  
  has_attached_file :image,
    :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "140x140>" },
    :url => "/system/:imageable/:id/:style/:filename",
    :path => ":rails_root/public:url"
  
  validates_attachment_size  :image, less_than: 15.megabytes
end
