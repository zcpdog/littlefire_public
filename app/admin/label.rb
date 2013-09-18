ActiveAdmin.register Label do
  menu :label => I18n.t("admin.label"), :parent => I18n.t("admin.management")
  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.actions
  end
  
  controller do
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:label).permit(:name)
      end
    end
  end
end
