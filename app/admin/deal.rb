ActiveAdmin.register Deal do
  menu :label => I18n.t("admin.deal"), :priority => 2
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do  
      f.input :merchant
      f.input :purchase_link
      f.input :amazing_price
    end
    f.inputs "Categories" do
      f.input :categories, :as => :check_boxes
    end
    if f.object.links.any?
      f.inputs "Links" do
        f.has_many :links do |link|
          link_to link.object.url,link.object.url
        end
      end
    end
    f.inputs "Title" do
      f.input :display_title, label: "Title", input_html: { :class => "tinymce" }
    end
    f.inputs "Reason" do
      f.input :display_body, label: "Reason", input_html: { :class => "tinymce" }
    end
    f.inputs "Extra" do
      f.input :display_body_extra, label: "Extra", input_html: { :class => "tinymce" }
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
      row :categories
      row :merchant
      row :purchase_link do
        link_to(deal.purchase_link,deal.purchase_link,target: "_blank") unless deal.purchase_link.nil?
      end
      row :amazing_price do
        t("admin.amazing_price") if deal.amazing_price
      end
      row :tile do
        deal.title
      end
      row "body" do 
        deal.body
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
  
  index do
    column :pictures do |deal|
      link_to(image_tag(deal.pictures.first.image.url(:tiny)), admin_deal_path(deal)) if deal.pictures.any?
    end
    column :state do |deal|
      if deal.waiting?
        status_tag "待审核"
      end
    end
    column :title do |deal|
      link_to deal.short_title, admin_deal_path(deal)
    end
    column :created_at
    column :updated_at
    default_actions
  end
  
  index :as => :grid do |deal|
    link_to(image_tag(deal.pictures.first.image.url(:tiny)), admin_deal_path(deal))
  end
  
  controller do
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:deal).permit(:merchant_id,:categoy_id,:purchase_link,
          :location,:due_date,:amazing_price,[links_attributes: [:url,:id,:_destroy]], :display_title,
          :display_body, :display_body_extra,[pictures_attributes: [:image, :id, :_destroy]],:category_ids=>[])
      end
    end
  end
end
