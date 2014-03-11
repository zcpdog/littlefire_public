require 'nokogiri'
class Deal < ActiveRecord::Base
  has_paper_trail
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :active, ->{ where(state: ACTIVE_STATES)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  
  ACTIVE_STATES = ["published","deprecated"]
  
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
  before_save :update_name_and_title
  before_save :do_check, unless: Proc.new {|deal| deal.new_record?}
  
  validates :title, length: { in: 5..200}
  validates :content, length: { maximum: 10000}
  validates_presence_of :title, :content
  
  state_machine :state, :initial => :unchecked do
    state :unchecked
    state :checking
    state :rejected
    state :published
    state :deprecated
    
    event :check do
      transition :unchecked => :checking
    end
    
    event :publish do
      transition :checking => :published, :if => lambda {|deal| deal.ready_to_go?}
    end
    
    event :reject do
      transition [:checking,:unchecked] => :rejected
    end
    
    event :deprecate do
      transition :published => :deprecated
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
  
  def ready_to_go?
    picture.present? and purchase_link.present? and categories.any?
  end
  
  rails_admin do
    list do
      field :id
      field :name
      field :state, :state
    end
    edit do
      field :categories do
        nested_form false
        inverse_of :deals
        associated_collection_scope do
          Proc.new { |scope| scope = scope.leaf}
        end
      end
      field :merchant
      field :purchase_link
      field :title, :ck_editor
      field :content, :ck_editor
      field :due_date, :datetime
      field :picture
    end
    
    state({
        events: {reject: 'btn-danger', publish: 'btn-success', deprecate: 'btn-warning' },
        states: {unchecked: 'label-important', checking: 'label-warning', published: 'label-success', 
          deprecated: 'label-warning', rejected: 'label-danger'},
        disable: [:check]
      })
  end
  
  def active?
    ACTIVE_STATES.include? self.state
  end
  
  def owned_by? theuser
    self.user == theuser
  end
  
  protected
    def update_content_plain_text
      self.content_plain_text = Nokogiri::HTML(content).text.gsub(/&nbsp;/,"")
    end
    
    def update_name_and_title
      self.name = Nokogiri::HTML(title).text.gsub(/&nbsp;/,"");
      self.title = self.title.gsub(/<(\/)?p>/,"");
    end
    
    def do_check
      self.state = "checking" if self.can_check?
    end
    
end
