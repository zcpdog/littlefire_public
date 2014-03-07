class Grade < ActiveRecord::Base
  paginates_per 20
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  
  belongs_to  :gradable, polymorphic: true, counter_cache: true
  belongs_to :user
  
  validates_presence_of :user, :gradable_type, :gradable_id
  validates :user , uniqueness: { scope: [:gradable_id, :gradable_type]}
end
