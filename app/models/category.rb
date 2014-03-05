class Category < ActiveRecord::Base
  has_paper_trail
  belongs_to  :parent, foreign_key: :parent_id , class_name: :Category
  has_many    :children, foreign_key: :parent_id , class_name: :Category , dependent: :destroy
  has_and_belongs_to_many :deals
  
  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  scope :root, ->{where("parent_id IS NULL")} 
  
  rails_admin do 
    list do
      field :name
      field :parent
      field :created_at
      field :updated_at
    end
    edit do
      field :name
      field :parent
    end
  end
end
