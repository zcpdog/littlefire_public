require 'nokogiri'
require 'domainatrix'
class Deal < ActiveRecord::Base
  include AASM
  
  default_scope {where(state: [:published,:deprecated]).order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  paginates_per 20
  
  belongs_to :user
  belongs_to :merchant
  
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories
  
  has_many   :links, dependent: :destroy
  accepts_nested_attributes_for :links
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  has_many   :grades, as: :gradable, dependent: :destroy
  has_many   :reports, dependent: :destroy
  
  has_many   :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  
  before_save :generate_info, if: Proc.new {|deal| deal.new_record?}
  before_save :update_plain_text, unless: Proc.new {|deal| deal.new_record?}
  
  validates :title, length: { in: 10..255}
  validates :body, length: { maximum: 10000}
  
  aasm_column :state
  aasm do
     state :unchecked, :initial => true
     state :checking
     state :accepted
     state :rejected
     state :published
     state :deprecated

     event :check do
       transitions :from => :unchecked, :to => :checking
     end
     
     event :accept do
       transitions :from => :checking, :to => :accepted
     end

     event :reject do
       transitions :from => [:unchecked, :checking, :accepted], :to => :rejected
     end
     
     event :publish do
       transitions :from => :accepted, :to => :published, :guard => :ready?
     end

     event :deprecate do
       transitions :from => :published, :to => :deprecated
     end
  end
  
  searchable do
    text :title, :boost => 5,:stored => true
    text :body,:stored => true
    time :created_at
    text :categories do
      categories.map { |category| category.name }
    end
  end
  handle_asynchronously :solr_index, :queue => 'solr_index'
  
  def short_title
    if title.length > 15
      title[0,15] << "..."
    else
      title
    end
  end
  
  def ready?
    true
  end
  
  protected
  
  def generate_info
    if self.links.any? and self.purchase_link.nil?
      self.purchase_link = self.links.first.url
      domainatrix = Domainatrix.parse(purchase_link)
      merchant_domain = "#{domainatrix.domain}.#{domainatrix.public_suffix}"
      self.merchant =  Merchant.find_by domain: merchant_domain
    end
    self.display_title = self.title
    
    if self.body.length > 200
      self.display_body = self.body[0..199]
      self.display_body_extra = self.body[200..self.body.length]
    else
      self.display_body = self.body
      self.display_body_extra = ""
    end
  end
     
  def update_plain_text
    if self.display_body_changed? or self.display_body_extra_changed? or self.display_title_changed?
      self.body = Nokogiri::HTML(display_body+display_body_extra).text
      self.title = Nokogiri::HTML(display_title).text
    end
  end
end
