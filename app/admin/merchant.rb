ActiveAdmin.register Merchant do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :url, as: :url
    end
    f.actions
  end
  
  controller do
    def resource_params
      # puts "=================================================="
#       puts params.require(:merchant).permit(:name,:url).inspect
#       puts "=================================================="
#       puts params.require
#       puts "=================================================="
      [params.require(:merchant).permit(:name,:url)]
    end
  end
end
