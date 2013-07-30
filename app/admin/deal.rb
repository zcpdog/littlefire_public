ActiveAdmin.register Deal do

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
