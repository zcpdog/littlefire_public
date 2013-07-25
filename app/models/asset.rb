class Asset < ActiveRecord::Base
  default_scope  { where("attachment_file_name IS NULL")}
  
  belongs_to :attachable, :polymorphic => true
end
