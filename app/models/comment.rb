class Comment < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  
  belongs_to  :user
  belongs_to  :deal, counter_cache: true
  has_many    :grades,  as: :gradable
  
  belongs_to :parent, foreign_key: :parent_id, class_name: :Comment
  has_many    :children, foreign_key: :parent_id, class_name: :Comment , dependent: :destroy
end
