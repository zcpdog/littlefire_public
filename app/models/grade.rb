class Grade < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  paginates_per 20
  scope :deal_grades, -> { where(gradable_type: :Deal) }
  scope :owned_by, ->(user) { where(user: user)}
  belongs_to :gradable, polymorphic: true
  belongs_to :user
  
  after_save :update_count
  
  validates :user , uniqueness: { scope: [:gradable_id, :gradable_type],
      message: "只能打分一次" }
  private 
  def update_count
    if agree
      self.gradable.agree_count += 1
    else
      self.gradable.disagree_count += 1
    end
    self.gradable.save!
  end
end
