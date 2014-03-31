class Article < ActiveRecord::Base
  include InteractionComponents
  include ContentPlainText
  include FriendlyIdComponents  
  include PaperTrailConfig
  include CacheManagement
  
  default_scope {order("created_at DESC")}
  scope :type_of, ->(type) { where(article_type: type)}
  scope :active, ->{ where(state: "published")}
  scope :owned_by, ->(user) { where(user: user)}
  paginates_per 20
  
  belongs_to :article_type

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
  
  def active?
    state == "published"
  end

  rails_admin do
    list do
      field :id
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
      field :article_type
      field :title, :text
      field :content, :text
      field :picture
    end
  end
end
