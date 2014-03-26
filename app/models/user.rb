require 'chinese_pinyin'
class User < ActiveRecord::Base  
  extend FriendlyId
  friendly_id :username_pinyin
  has_paper_trail only: [:username,:email,:password,:credit]
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :async

  has_one       :picture, as: :imageable, dependent: :destroy
  accepts_nested_attributes_for :picture
  has_many      :deals
  has_many      :experience
  has_many      :favorites, dependent: :destroy
  has_many      :comments
  has_many      :grades
  has_many      :authentications
  validates     :username, presence: true, uniqueness: true, length: { in: 2..15}
  validates_format_of :username, :with => /\A[\d\w\P{ASCII}]+\z/
  
  after_save  :generate_avatar, if: Proc.new {|user| user.picture.nil?}
  after_save  :generate_username_pinyin!, if: Proc.new{|obj|obj.username_pinyin.nil?}
  after_save  :expire_cache
  
  rails_admin do
    list do
      field :id
      field :username
      field :email
      field :current_sign_in_at
      field :current_sign_in_ip
      field :credit
    end
    edit do
      field :username do
        read_only true
      end
      field :email do
        read_only true
      end
      field :credit
    end
  end
  
  def self.serialize_from_session(key, salt)
    single_key = key.is_a?(Array) ? key.first : key
    Rails.cache.fetch("user:#{single_key}") do
       User.where(:id => single_key).entries.first
    end
  end
  
  def generate_username_pinyin
    self.username_pinyin = Pinyin.t(self.username, splitter: '-')<<"-#{self.id}"
  end
  
  def generate_username_pinyin!
    self.generate_username_pinyin
    self.save
  end
  
  private
  def generate_avatar
    AvatarGenerator.perform_async(self.id)
  end
  def expire_cache
    Rails.cache.delete("user:#{id}")
  end
end
