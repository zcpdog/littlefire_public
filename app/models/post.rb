require 'nokogiri'
class Post < ActiveRecord::Base
  include AASM
  
  paginates_per 20
  
  default_scope {where(state: :published).order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  
  belongs_to :user
  belongs_to :label
  
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :categories
  
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :favorites, as: :favorable, dependent: :destroy
  
  has_many   :pictures, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true
  
  validates :title, length: { in: 10..255}
  validates :body, length: { in:100..50000}
  validates_presence_of :label
  
  before_save :update_plain_text
  
  aasm_column :state
  aasm do
     state :started, :initial => true
     state :finished
     state :published
     
     event :finish do
       transitions :from => :started, :to => :finished
     end
  
     event :publish do
       transitions :from => :finished, :to => :published
     end
  end
  
  def short_title
    if plain_text_title.length > 15
      plain_text_title[0,15] << "..."
    else
      plain_text_title
    end
  end
  
  def update_plain_text
    if self.title_changed? or self.body_changed?
      self.plain_text_title = Nokogiri::HTML(title).text
      self.plain_text_body = Nokogiri::HTML(body).text
    end
  end
  
end
