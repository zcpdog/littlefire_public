require 'nokogiri'
class Discovery < ActiveRecord::Base
  has_paper_trail :ignore => [:comments_count, :favorites_count, :agree_count, :disagree_count]
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :day_of, ->(time) { where(created_at: time..time+1.month)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  scope :active, ->{ where(state: [:editable,:uneditable])}
  
  paginates_per 20
  belongs_to :user
  belongs_to :merchant

  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  has_many   :grades, as: :gradable, dependent: :destroy
  has_many   :reports, as: :reportable, dependent: :destroy

  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  has_one   :credit, as: :creditable, dependent: :destroy
  accepts_nested_attributes_for :credit, allow_destroy: true

  before_save :update_content_plain_text, if: Proc.new {|discovery| discovery.content_changed?}
  before_save :update_name_and_title

  validates :title, length: { in: 3..60}
  validates :content, length: { maximum: 1500}
  validates_presence_of :title, :content, :picture, :merchant, :purchase_link
  after_save :expire_first_five_pages
  
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

  private
    def expire_first_five_pages
      Rails.cache.delete([self.class.name,"published",nil])
      [1..5].each{|i| Rails.cache.delete([self.class.name,"published",i])}
    end
end
