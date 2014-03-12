class Grade < ActiveRecord::Base
  after_save :update_count
  
  paginates_per 20
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  
  belongs_to  :gradable, polymorphic: true
  belongs_to :user
  
  validates_presence_of :user, :gradable_type, :gradable_id, :grade_type
  validates :user , uniqueness: { scope: [:gradable_id, :gradable_type]}
  
  def update_count
    if grade_type.eql? "up"
      self.gradable.agree_count +=1
    else
      self.gradable.disagree_count +=1
    end
    self.gradable.save!
  end
end
