class Favorite < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  paginates_per 20
  belongs_to :favorable, polymorphic: true, counter_cache: true
  belongs_to :user
  validates :favorable_id, uniqueness: { scope: [:user, :favorable_type], message: "只能收藏一次" }
  validates_presence_of :user, :favorable
end
