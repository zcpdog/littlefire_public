class Discovery < ActiveRecord::Base
  include InteractionComponents
  include ContentPlainText
  include FriendlyIdComponents  
  include PaperTrailConfig
  include CacheManagement
  include AdminActionRecord
  
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :day_of, ->(time) { where(created_at: time..time+1.month)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  scope :active, ->{ where(state: [:editable,:uneditable])}
  
  paginates_per 20
  belongs_to :user
  belongs_to :merchant

  validates :title, length: { in: 3..60}
  validates :content, length: { maximum: 1500}
  validates_presence_of :title, :content, :picture, :merchant, :purchase_link
    
  state_machine :state, :initial => :editable do
    state :editable
    state :uneditable
    state :hidden
    after_transition :on => [:hide, :publish], :do => :expire_first_five_pages
    event :lock do
      transition :editable => :uneditable
    end
    event :unlock do
      transition :uneditable => :editable 
    end
    event :hide do
      transition [:uneditable,:editable] => :hidden
    end
    event :publish do
      transition :hidden => :uneditable
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
      field :merchant
      field :purchase_link do
        html_attributes do
          {size: '100'}
        end
      end
      field :title, :text
      field :content
      field :due_date, :datetime
      field :picture
      field :credit
    end
  
    state({
        events: {reject: 'btn-danger', publish: 'btn-success', deprecate: 'btn-warning' },
        states: {unchecked: 'label-important', checking: 'label-warning', published: 'label-success', 
          deprecated: 'label-warning', rejected: 'label-danger'},
        disable: [:check]
      })
  end
  
  def self.cached_published page=1
    Rails.cache.fetch([name, "published", page], expires_in: 1.hour) do
      Kaminari.paginate_array(active.includes([:user,:picture,:merchant]).to_a).page(page)
    end
  end

  def active?
    ["editable","uneditable"].include? self.state
  end

  def owned_by? theuser
    self.user == theuser
  end
end
