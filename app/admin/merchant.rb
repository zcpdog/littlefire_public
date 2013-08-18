ActiveAdmin.register Merchant do
  menu :label => I18n.t("admin.merchant"), :parent => I18n.t("admin.management")
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :link, as: :url
    end
    f.actions
  end
  
  controller do
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:merchant).permit(:name,:url)
      end
    end
  end
end
