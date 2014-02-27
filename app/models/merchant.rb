class Merchant < ActiveRecord::Base
  has_paper_trail
  has_many  :deals
  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  rails_admin do
    list do
      field :id
      field :name
      field :link
      field :domain
      field :code
    end
    
    edit do
      field :name
      field :link
      field :domain
      field :code
    end
  end
end
