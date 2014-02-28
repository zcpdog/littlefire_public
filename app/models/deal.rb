require 'nokogiri'
require 'domainatrix'
class Deal < ActiveRecord::Base
  include AASM
  has_paper_trail
  #default_scope {where(state: [:published,:deprecated]).order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  
  belongs_to :user
  belongs_to :merchant
  
  has_and_belongs_to_many :categories
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  has_many   :grades, as: :gradable, dependent: :destroy
  has_many   :reports, dependent: :destroy
  
  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  before_save :generate_info, if: Proc.new {|deal| deal.new_record?}
  before_save :update_name, unless: Proc.new {|deal| deal.new_record?}
  
  validates :title, length: { in: 10..255}
  validates :content, length: { maximum: 10000}
  
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
    text :name, :boost => 5,:stored => true
    text :content,:stored => true
    text :body,:stored => true
    time :created_at
    text :categories do
      categories.map { |category| category.name }
    end
  end
  
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
  
  rails_admin do
    list do
      field :id
      field :name
      field :state
    end
    edit do
      field :categories do
        nested_form false
        inverse_of :deals
      end
      field :merchant
      field :purchase_link
      field :title, :ck_editor
      field :content, :ck_editor
      field :due_date, :datetime
      field :amazing_price
      field :picture
    end
  end
  
  protected
    def generate_info
      self.name = Nokogiri::HTML(title).text.gsub(/&nbsp;/,"").strip unless self.title.nil?
      self.purchase_link = self.link unless self.link.nil?
    end
    
    def update_name
      self.name = Nokogiri::HTML(title).text.gsub(/&nbsp;/,"").strip if self.title_changed?
    end
end
