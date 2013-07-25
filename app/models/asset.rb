class Asset < ActiveRecord::Base
  default_scope  { where("attachment_file_name NOT NULL")}
  
  belongs_to :attachable, :polymorphic => true
  
  validates_attachment_size   :attachment, :less_than => 10.megabytes
end
