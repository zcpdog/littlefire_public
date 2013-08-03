class Grade < ActiveRecord::Base
  belongs_to :gradable, polymorphic: true
  belongs_to :user
end
