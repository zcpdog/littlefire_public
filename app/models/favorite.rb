class Favorite < ActiveRecord::Base
  paginates_per 20
  
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  
  belongs_to :favorable, polymorphic: true, counter_cache: true
  belongs_to :user
  
  validates :favorable_id, uniqueness: { scope: [:user, :favorable_type]}
  validates_presence_of :user, :favorable
  
  rails_admin do
    list do
      field :user
      field :favorable
    end
  end
end
