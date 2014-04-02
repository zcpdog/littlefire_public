class Credit < ActiveRecord::Base
  has_paper_trail
  belongs_to :creditable, polymorphic: true
  validates :points, presence: true, numericality: true
  validates :creditable, presence: true
  
  after_save :update_user_credit
  
  rails_admin do
    list do
      field :id
      field :creditable
      field :points
    end
    edit do
      field :points do
        default_value do
          0
        end
      end
    end
  end
  
  private
  def update_user_credit
    if self.creditable.user.present?
      user = self.creditable.user
      user.credit += points
      user.save
    end
  end
end
