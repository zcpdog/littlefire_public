class Favorite < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  paginates_per 20
  belongs_to :deal, counter_cache: true
  belongs_to :user
  
  scope :stored_by, ->(user) { where(user: user)}
end
