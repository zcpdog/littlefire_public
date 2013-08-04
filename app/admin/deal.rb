ActiveAdmin.register Deal do
  controller do
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:deal).permit(:user_id,:merchant_id,:categoy_id,:title,
        :body,:location,:due_date,:amazing_price)
      end
    end
  end
end
