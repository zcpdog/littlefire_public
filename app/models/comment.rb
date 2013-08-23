class Comment < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  paginates_per 20
  belongs_to  :user
  belongs_to  :deal, counter_cache: true
  has_many    :grades,  as: :gradable
  
  belongs_to :parent, foreign_key: :parent_id, class_name: :Comment
  has_many    :children, foreign_key: :parent_id, class_name: :Comment , dependent: :destroy
  
  validates :content, length: { in: 5..140 }, presence: true
  validates :user, presence: true
  validates :deal, presence: true
end
