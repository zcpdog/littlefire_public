ActiveAdmin.register Merchant do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :url, as: :url
    end
    f.actions
  end
  
  controller do
    def update 
    end
    
    private 
    def permitted_params
      puts "iamin=================================="
      params.permit(merchant: [:name, :url])
    end
  end
end
