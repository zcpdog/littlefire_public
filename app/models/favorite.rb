class Favorite < ActiveRecord::Base
  default_scope order("created_at DESC")
  
  belongs_to :deal, counter_cache: true
  belongs_to :user
  
  scope :stored_by, ->(user) { order("id DESC").where(user: user)}
end
