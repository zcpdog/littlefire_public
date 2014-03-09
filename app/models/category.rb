class Category < ActiveRecord::Base
  has_paper_trail
  belongs_to  :parent, foreign_key: :parent_id , class_name: :Category
  has_many    :children, foreign_key: :parent_id , class_name: :Category , dependent: :destroy
  has_and_belongs_to_many :deals
  
  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  scope :root, ->{where("parent_id IS NULL")} 
  scope :leaf, ->{where("parent_id IS NOT NULL")} 
  
  validates :name, presence: true, uniqueness: true, length: { in: 2..10}
  
  rails_admin do 
    list do
      field :name
      field :parent do
        pretty_value do
          bindings[:object].parent.name if bindings[:object].parent.present?
        end
      end
      field :created_at
      field :updated_at
    end
    edit do
      field :name
      field :parent do
        associated_collection_scope do
          Proc.new { |scope| scope = scope.root}
        end
      end
    end
  end
end
