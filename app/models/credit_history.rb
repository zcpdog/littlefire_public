class CreditHistory < ActiveRecord::Base
  belongs_to :creditable, polymorphic: true
  belongs_to :user
end
