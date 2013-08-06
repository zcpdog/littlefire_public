ActiveAdmin.register Deal do
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :user
      f.input :category,:input_html=>{:class=>"hello world"}
      f.input :merchant
      f.input :purchase_link
      f.input :amazing_price
    end
    if f.object.links.any?
      f.inputs "Links" do
        f.has_many :links do |link|
          link_to link.object.url,link.object.url
        end
      end
    end
    f.inputs "Title" do
      f.input :title, label: "Title", input_html: { :class => "tinymce" }
    end
    f.inputs "Reason" do
      f.input :body, label: "Reason", input_html: { :class => "tinymce" }
    end
    f.inputs "Pictures" do
      f.has_many :pictures do |picture|
        picture.input :image, :as => :file, :label => "Image",
          :hint => picture.template.image_tag(picture.object.image.url(:medium))
        picture.input :_destroy, :as=>:boolean, :required => false, :label => 'Remove image'
      end
    end
    f.actions
  end
  
  show do |deal|
    attributes_table do
      row :user do
        link_to deal.user.username admin_user_path(deal.user) unless deal.user.nil?
      end
      row :category
      row :merchant
      row :purchase_link do
        link_to(deal.purchase_link,deal.purchase_link) unless deal.purchase_link.nil?
      end
      row :amazing_price do
        "小伙伴价格" if deal.amazing_price
      end
      row :tile do
        deal.title.html_safe
      end
      row "body" do 
        deal.body.html_safe
      end
      row "Images" do
         ul do
          deal.pictures.each do |pic|
            li do 
              image_tag(pic.image.url(:medium))
            end
          end
         end
      end
    end
    active_admin_comments
  end
  
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
