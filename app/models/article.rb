class Article < ActiveRecord::Base
  has_paper_trail :ignore => [:comments_count, :favorites_count, :agree_count, :disagree_count]
  default_scope {order("created_at DESC")}
  scope :type_of, ->(type) { where(article_type_id: type)}
  scope :active, ->{ where(state: "published")}
  scope :owned_by, ->(user) { where(user: user)}
  paginates_per 20

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

  validates :title, length: { in: 5..30}
  validates :content, length: { maximum: 1500}
  validates_presence_of :title, :content, :picture, :article_type

  state_machine :state, :initial => :editing do
    state :editing
    state :published
    state :hidden
      
    event :publish do
      transition :editing => :published
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
      field :name
      field :state, :state
    end
    edit do
      field :article_type
      field :title, :text
      field :content, :text
      field :picture
    end
  end

  protected
    def update_content_plain_text
      self.content_plain_text = Nokogiri::HTML(content).text.gsub(/&nbsp;/,"")
    end
  
    def update_name_and_title
      self.name = Nokogiri::HTML(title).text.gsub(/&nbsp;/,"");
      self.title = self.title.gsub(/<(\/)?p>/,"");
    end
end
