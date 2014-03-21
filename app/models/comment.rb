require 'nokogiri'
class Comment < ActiveRecord::Base
  paginates_per 20
  
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :occured_between, ->(time_begin,time_end) { where(created_at: time_begin..time_end)}
  scope :month_of, ->(time) { where(created_at: time..time+1.month)}
  
  belongs_to  :user
  belongs_to  :commentable, polymorphic: true, counter_cache: true
  has_many    :grades,  as: :gradable
  belongs_to  :parent, foreign_key: :parent_id, class_name: :Comment
  has_many    :children, foreign_key: :parent_id, class_name: :Comment , dependent: :destroy
  
  validates :content, length: { in: 5..140 }
  validates_presence_of :user, :commentable, :content
  
  before_save :generate_html, if: Proc.new {|comment| comment.new_record?}
  
  EMOTIONS = ["Laugh", "Angry", "Blush", "Crazy", "Crying", "Sweat", "Grin", "Hot", "LargeGasp", "Naughty"]
  
  rails_admin do
    list do
      field :user
      field :content_origin
      field :commentable
    end
  end
  
  protected
    def generate_html
      self.content_origin = self.content
      self.content = Nokogiri::HTML(content).text.gsub(/&nbsp;/,"")
      EMOTIONS.each do |em|
        self.content.gsub!(/\[#{em}\]/, ActionController::Base.helpers.image_tag("#{em}.png"))
      end
      self.content.gsub!(/@([\w\P{ASCII}]+)(\s{2})/){
        user = User.find_by(username: $1)
        if user.present?
          ActionController::Base.helpers.link_to($&, "/user/#{user.username}", target: "_blank")
        else
          $&
        end
      }
    end
end
