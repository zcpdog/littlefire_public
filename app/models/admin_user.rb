class AdminUser < ActiveRecord::Base
  has_paper_trail
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  validates_presence_of :role
  validates :username, :presence => true, :uniqueness => true
  rails_admin do
    list do
      field :username
      field :email
      field :role do
        pretty_value do
          ROLES_CN[bindings[:object].role]
        end
      end
      field :current_sign_in_ip
      field :current_sign_in_at
    end
    edit do
      field :username
      field :email
      field :password, :password 
      field :role, :enum do 
        enum do
          ROLES_ENUM[ROLES_RANK[bindings[:view]._current_user.role]+1..ROLES_RANK.size-1].reverse
        end
      end
    end
  end
  
  ROLES = ["admin","manager","staff"]
  ROLES_RANK = {"admin"=>0,"manager"=>1,"staff"=>2}
  ROLES_CN = {"admin"=>I18n.t("role.admin"),"manager"=>I18n.t("role.manager"),"staff"=>I18n.t("role.staff")}
  ROLES_ENUM = [[I18n.t("role.admin"),"admin"],[I18n.t("role.manager"),"manager"],[I18n.t("role.staff"),"staff"]]
  
  def has_role? the_role
    role.eql? the_role
  end
end
