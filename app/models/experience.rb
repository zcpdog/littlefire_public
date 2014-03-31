class Experience < ActiveRecord::Base
  include InteractionComponents
  include ContentPlainText
  include FriendlyIdComponents
  include PaperTrailConfig
  include CacheManagement
  
  default_scope {order("created_at DESC")}
  scope :active, ->{ where(state: "published")}
  scope :owned_by, ->(user) { where(user: user)}
  
  paginates_per 20
  
  belongs_to :user

  validates :title, length: { in: 5..200}
  validates :content, length: { maximum: 15000}
  validates_presence_of :title, :content, :picture, :user

  before_save :record_published_time, if: Proc.new{|experience| experience.top?}
  
  state_machine :state, :initial => :checking do
    state :checking
    state :published
    state :hidden
    
    after_transition :on => [:hide, :publish], :do => :expire_first_five_pages
    before_transition :on => :publish, :do => :record_published_time
    
    event :publish do
      transition :checking => :published
    end
    event :hide do
      transition :published => :hidden 
    end
    event :republish do
      transition  :hidden => :published
    end
  end

  rails_admin do
    list do
      field :id
      field :user
      field :name
      field :state, :state
    end
    edit do
      field :user, :hidden do
        help ""
        default_value do
          bindings[:view]._current_user.user
        end
      end
      field :title, :text
      field :content, :text
      field :related_deal_id
      field :picture
      field :credit
    end
  end
  
  def self.cached_published page=1
    Rails.cache.fetch([name, "published", page], expires_in: 1.hour) do
      Kaminari.paginate_array(active.includes([:user,:picture]).to_a).page(page)
    end
  end
  
  def active?
    state == "published"
  end
  
  def owned_by? theuser
    self.user == theuser
  end
    
  private
    def record_published_time
      self.published_at = Time.zone.now
    end
end
