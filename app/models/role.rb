class Role < ActiveRecord::Base
  has_many  :users
  
  def self.admin 
    Role.find_by key: :admin
  end
  
  def self.customer
    Role.find_by key: :customer
  end
  
  def self.provider
    Role.find_by key: :provider
  end
end
