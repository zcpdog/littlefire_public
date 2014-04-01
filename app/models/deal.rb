class Deal < ActiveRecord::Base
  include InteractionComponents
  include ContentPlainText
  include FriendlyIdComponents  
  include PaperTrailConfig
  include CacheManagement
  
  default_scope {order("deals.published_at DESC, deals.created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :active, ->{ where(state: ACTIVE_STATES)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  
  ACTIVE_STATES = ["published","deprecated"]
  
  paginates_per 20
  belongs_to :user
  belongs_to :merchant
  
  has_and_belongs_to_many :categories
  
  before_save :do_check, unless: Proc.new {|deal| deal.new_record?}
  before_save :record_published_time, if: Proc.new{|deal| deal.top?}
  validates :title, length: { in: 5..200}
  validates :content, length: { maximum: 10000}
  validates_presence_of :title, :content
  
  state_machine :state, :initial => :unchecked do
    state :unchecked
    state :checking
    state :rejected
    state :published
    state :deprecated
    
    after_transition :on => :publish, :do => :expire_first_five_pages
    before_transition :on => :publish, :do => :record_published_time
    
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
    time :published_at, :stored => true
    time :created_at, :stored => true
  end
  
  def ready_to_go?
    picture.present? and purchase_link.present? and categories.any?
  end
  
  rails_admin do
    list do
      field :id
      field :user
      field :name
      field :state, :state
      field :top
    end
    edit do
      field :user_id, :hidden do
        help ""
        default_value do
          bindings[:view]._current_user.user.try(:id)
        end
      end
      field :categories do
        nested_form false
        inverse_of :deals
        associated_collection_scope do
          Proc.new { |scope| scope = scope.leaf}
        end
      end
      field :merchant
      field :purchase_link, :text
      field :title, :text
      field :content
      field :due_date, :datetime
      field :picture
      field :credit
      field :top
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
  
  def self.cached_published page=1
    Rails.cache.fetch([name, "published", page], expires_in: 1.hour) do
      Kaminari.paginate_array(active.includes([:user,:picture,:merchant,:categories]).to_a).page(page)
    end
  end
  
  protected
    def do_check
      self.state = "checking" if self.can_check?
    end
    
  private
    def record_published_time
      self.published_at = Time.zone.now
    end
  end
