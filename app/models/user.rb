class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    
  belongs_to    :role
  has_one       :picture, as: :imageable
  has_one       :coin, dependent: :destroy
  
  before_save :make_sure_user_has_a_role
  def role? somerole
    self.role.key == somerole
  end
  
  private
  def make_sure_user_has_a_role
    if role.nil?
      role = Role.customer
    end
  end
  
end
