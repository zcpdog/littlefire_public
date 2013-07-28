class Viewpoint < ActiveRecord::Base
  belongs_to  :pointable, polymorphic: true
  belongs_to  :user
end
