class AdminUser < ActiveRecord::Base
  has_paper_trail only: [:username,:email,:password]
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  validates_presence_of :role
  validates :username, :presence => true, :uniqueness => true
  after_save :expire_cache
  
  belongs_to :user
  
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
          ROLES_ENUM[ROLES_RANK[bindings[:view]._current_user.role]..ROLES_RANK.size-1].reverse
        end
      end
      field :user
    end
  end
  
  ROLES = ["admin","manager","staff"]
  ROLES_RANK = {"admin"=>0,"manager"=>1,"staff"=>2}
  ROLES_CN = {"admin"=>I18n.t("role.admin"),"manager"=>I18n.t("role.manager"),"staff"=>I18n.t("role.staff")}
  ROLES_ENUM = [[I18n.t("role.admin"),"admin"],[I18n.t("role.manager"),"manager"],[I18n.t("role.staff"),"staff"]]
  
  def has_role? the_role
    role.eql? the_role
  end
  
  def self.serialize_from_session(key, salt)
    single_key = key.is_a?(Array) ? key.first : key
    Rails.cache.fetch("admin_user:#{single_key}") do
       AdminUser.where(:id => single_key).entries.first
    end
  end
  
  private 
  def expire_cache
    Rails.cache.delete("admin_user:#{id}")
  end
end
