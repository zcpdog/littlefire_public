ActiveAdmin.register AdminUser do
  menu :label => I18n.t("admin.admin_user"), :parent => I18n.t("admin.management")
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  
  controller do
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:admin_user).permit(:email,:password,:password_confirmation)
      end
    end
  end
end
