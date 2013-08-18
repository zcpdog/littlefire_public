class Picture < ActiveRecord::Base
  default_scope { where("image_file_name IS NOT NULL")}
  belongs_to :imageable, polymorphic: true
  
  has_attached_file :image,
    :styles => { :large => "500x500>", :medium => "200x200>", :thumb => "130x130>", :tiny => "50x50>" },
    :url => "/system/:imageable/:id/:style/:filename",
    :path => ":rails_root/public:url"
    
  validates_attachment_size  :image, less_than: 1.megabytes
  
  def image_style
    case imageable_type
    when "User"
      { :medium => "115x115>", :thumb => "88x88>", :tiny => "50x50>" }
    when "Deal"
      { :large => "500x500>", :medium => "200x200>", :thumb => "130x130>", :tiny => "50x50>" }
    end
  end
end
