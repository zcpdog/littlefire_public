class Merchant < ActiveRecord::Base
  has_many  :deals
  has_one   :picture, as: :imageable, dependent: :destroy
  #accepts_nested_attributes_for :picture, allow_destroy: true
  accepts_nested_attributes_for :picture
end
