class Grade < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  paginates_per 20
  scope :deal_grades, -> { where(gradable_type: :Deal) }
  scope :owned_by, ->(user) { where(user: user)}
  belongs_to  :gradable, polymorphic: true, counter_cache: true
  belongs_to :user
  
  validates :user , uniqueness: { scope: [:gradable_id, :gradable_type],
      message: "只能打分一次" }
end
