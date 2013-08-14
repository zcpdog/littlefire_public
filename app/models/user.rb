class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many      :deals
  has_many      :favorites, dependent: :destroy
  has_many      :credit_histories, dependent: :destroy
  has_many      :comments
  has_many      :grades
  
  has_attached_file :avatar,
    :styles => { :medium => "115x115>", :thumb => "88x88>", :tiny => "50x50>" },
    :url => "/system/:user/:id/:style/:filename",
    :path => ":rails_root/public:url"
  
end
