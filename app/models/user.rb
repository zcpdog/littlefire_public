class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:weibo]
  
  has_one       :picture, as: :imageable, dependent: :destroy
  has_many      :deals
  has_many      :favorites, dependent: :destroy
  has_many      :credit_histories, dependent: :destroy
  has_many      :comments
  has_many      :grades
  has_many      :authentications
  
end
