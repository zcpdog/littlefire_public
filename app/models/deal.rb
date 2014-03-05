require 'nokogiri'
class Deal < ActiveRecord::Base
  include AASM
  has_paper_trail
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :active, ->{ where(state: [:published,:deprecated])}
  paginates_per 20
  belongs_to :user
  belongs_to :merchant
  
  has_and_belongs_to_many :categories
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  has_many   :grades, as: :gradable, dependent: :destroy
  has_many   :reports, dependent: :destroy
  
  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  before_save :update_content_plain_text, if: Proc.new {|deal| deal.content_changed?}
  before_save :update_name, if: Proc.new {|deal| deal.title_changed?}
  
  validates :title, length: { in: 5..200}
  validates :content, length: { maximum: 10000}
  validates_presence_of :title, :content
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
  
  searchable :ignore_attribute_changes_of => [ :purchase_link, :comments_count, :grades_count, 
      :favorites_ount, :updated_at, :due_date, :amazing_price ] do
    text :title, :boost => 5, :stored => true
    text :content_plain_text, :stored => true
    string :state, :stored => true
    text :categories, :stored => true do
      categories.map { |category| category.name }
    end
    time :created_at, :stored => true
  end
  
  def ready?
    picture.present? and purchase_link.present? and categories.any?
  end
  
  rails_admin do
    list do
      field :id
      field :title
      field :state
    end
    edit do
      field :categories do
        nested_form false
        inverse_of :deals
      end
      field :merchant
      field :purchase_link
      field :title
      field :content, :ck_editor
      field :due_date, :datetime
      field :picture
    end
  end
  
  protected
    def update_content_plain_text
      self.content_plain_text = Nokogiri::HTML(content).text.gsub(/&nbsp;/,"")
    end
    
    def update_name
      self.name = Nokogiri::HTML(title).text.gsub(/&nbsp;/,"");
    end
end
