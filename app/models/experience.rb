class Experience < ActiveRecord::Base
  has_paper_trail :ignore => [:comments_count, :favorites_count, :agree_count, :disagree_count]
  default_scope {order("created_at DESC")}
  scope :active, ->{ where(state: "published")}
  scope :owned_by, ->(user) { where(user: user)}
  
  paginates_per 20
  
  belongs_to :user
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  has_many   :grades, as: :gradable, dependent: :destroy
  has_many   :reports, as: :reportable, dependent: :destroy

  has_one   :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true
  
  has_one   :credit, as: :creditable, dependent: :destroy
  accepts_nested_attributes_for :credit, allow_destroy: true
  
  before_save :update_content_plain_text, if: Proc.new {|article| article.content_changed?}
  before_save :update_name_and_title

  validates :title, length: { in: 5..200}
  validates :content, length: { maximum: 15000}
  validates_presence_of :title, :content, :picture, :user

  state_machine :state, :initial => :checking do
    state :checking
    state :published
    state :hidden
    after_transition :on => [:hide, :publish], :do => :expire_first_five_pages
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
