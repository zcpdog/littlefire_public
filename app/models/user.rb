class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:async,:confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:weibo]
  
  has_one       :picture, as: :imageable, dependent: :destroy
  has_many      :deals
  has_many      :favorites, dependent: :destroy
  has_many      :credit_histories, dependent: :destroy
  has_many      :comments
  has_many      :grades
  has_many      :authentications
  
  rails_admin do
    list do
      field :id
      field :username
      field :email
      field :current_sign_in_at
      field :current_sign_in_ip
      field :credit
    end
  end
  
end
