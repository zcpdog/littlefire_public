class CreditHistory < ActiveRecord::Base
  has_paper_trail
  belongs_to :creditable, polymorphic: true
  belongs_to :user
end
