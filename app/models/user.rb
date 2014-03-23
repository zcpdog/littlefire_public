class User < ActiveRecord::Base  
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
  after_save :generate_avatar, if: Proc.new {|user| user.picture.nil?}
  
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
  
  private
  def generate_avatar
    AvatarGenerator.perform_async(self.id)
  end
end
