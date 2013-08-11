class Favorite < ActiveRecord::Base
  belongs_to :deal
  belongs_to :user
  
  scope :stored_by, ->(user) { order("id DESC").where(user: user)}
end
