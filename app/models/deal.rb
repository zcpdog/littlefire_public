class Deal < ActiveRecord::Base
  paginates_per 10
  include AASM
  
  belongs_to :user
  belongs_to :category
  belongs_to :merchant
  has_many   :deal_urls
  
  has_many   :comments, dependent: :destroy
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
   
   
end
