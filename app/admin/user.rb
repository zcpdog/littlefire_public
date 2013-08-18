ActiveAdmin.register User do
  menu :label => I18n.t("admin.user"), :parent => I18n.t("admin.management"), :priority => 2
  index do
    column :email
    column :username
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
