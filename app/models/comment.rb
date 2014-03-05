require 'nokogiri'
class Comment < ActiveRecord::Base
  default_scope {order("created_at DESC")}
  scope :owned_by, ->(user) { where(user: user)}
  scope :commented_by, ->(user) { where(user: user)}
  paginates_per 20
  belongs_to  :user
  belongs_to  :commentable, polymorphic: true, counter_cache: true
  has_many    :grades,  as: :gradable
  belongs_to  :parent, foreign_key: :parent_id, class_name: :Comment
  has_many    :children, foreign_key: :parent_id, class_name: :Comment , dependent: :destroy
  
  validates :content, length: { in: 5..140 }, presence: true
  validates_presence_of :user, :commentable
  
  before_save :generate_html, if: Proc.new {|comment| comment.new_record?}
  
  EMOTIONS = ["Laugh", "Angry", "Blush", "Crazy", "Crying", "Sweat", "Grin", "Hot", "LargeGasp", "Naughty"]
  
  protected
    def generate_html
      self.content = Nokogiri::HTML(content).text.gsub(/&nbsp;/,"")
      EMOTIONS.each do |em|
        self.content.gsub!(/\[#{em}\]/, ActionController::Base.helpers.image_tag("#{em}.png"))
      end
      self.content.gsub!(/@(\w+)(\s{2})/){
        user = User.where(username: $1).take
        if user.present?
          ActionController::Base.helpers.link_to($&, "/user/#{self.user.username}", target: "_blank")
        else
          $&
        end
      }
    end
end
