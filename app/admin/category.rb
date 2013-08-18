ActiveAdmin.register Category do
  menu :label => I18n.t( "admin.category"), :parent => I18n.t("admin.management")
  
  controller do
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:deal).permit(:user_id,:merchant_id,:categoy_id,:title,:purchase_link,
          :body,:location,:due_date,:amazing_price,[links_attributes: [:url,:id,:_destroy]],
          [pictures_attributes: [:image, :id, :_destroy]])
      end
    end
  end
end
