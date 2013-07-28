class Comment < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :deal
  has_many    :viewpoints,  as: :pointable
  
  belongs_to :parent, foreign_key: :parent_id, class_name: :Comment
  has_many    :children, foreign_key: :parent_id, class_name: :Comment , dependent: :destroy
end
