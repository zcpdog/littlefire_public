class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  rails_admin do
    list do
      field :id
      field :username
      field :email
      field :current_sign_in_at
      field :current_sign_in_ip
      field :role
    end
  end
  
  ROLES = ["admin","manager","staff"]
  ROLES_RANK = {"admin"=>1,"manager"=>2,"staff"=>3}
  ROLES_CN = {"admin"=>"系统管理员","manager"=>"管理员","staff"=>"员工"}
  
  def admin?
    role.eql? "admin"
  end
  
  def manager?
    role.eql? "manager"
  end
  
  def staff?
    role.eql? "staff"
  end
end
