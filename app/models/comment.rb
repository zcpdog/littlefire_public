class Comment < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  paginates_per 20
  belongs_to  :user
  belongs_to  :commentable, polymorphic: true, counter_cache: true
  has_many    :grades,  as: :gradable
  belongs_to  :parent, foreign_key: :parent_id, class_name: :Comment
  has_many    :children, foreign_key: :parent_id, class_name: :Comment , dependent: :destroy
  
  validates :content, length: { in: 5..140 }, presence: true
  validates_presence_of :user, :commentable
end
