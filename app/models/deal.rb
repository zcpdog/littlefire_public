class Deal < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  require 'domainatrix'
  paginates_per 20
  include AASM
  
  belongs_to :user
  belongs_to :category
  belongs_to :merchant
  
  has_many   :links, dependent: :destroy
  accepts_nested_attributes_for :links
  
  has_many   :comments, dependent: :destroy
  has_many   :favorites,  dependent: :destroy
  has_many   :grades, as: :gradable, dependent: :destroy
  has_many   :reports, dependent: :destroy
  
  has_many   :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  
  aasm_column :state
  aasm do
     state :waiting, :initial => true
     state :showing
     state :rejected
     state :deprecated

     event :accept do
       transitions :from => :waiting, :to => :showing
     end

     event :reject do
       transitions :from => :waiting, :to => :rejected
     end

     event :outmode do
       transitions :from => :showing, :to => :deprecated
     end
   end
  
  def generate_info
    if links.any?
      purchase_link = links.first.url
      domainatrix = Domainatrix.parse(purchase_link)
      merchant_domain = "#{domainatrix.domain}.#{domainatrix.public_suffix}"
      merchant =  Merchant.find_by domain: merchant_domain
    end
    display_title = title
    
    if body.length > 200
      display_body = body[0..199]
      display_body_extra = body[200..body.length]
    else
      display_body = body
    end
  end
  
  searchable do
    text :title, :boost => 5
    text :body
  end
end
