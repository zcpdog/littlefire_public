ActiveAdmin.register Deal do
  scope :unchecked
  scope :checking
  scope :accepted
  scope :published
  scope :deprecated
  scope :rejected
  menu :label => I18n.t("admin.deal"), :priority => 2
  batch_action :destroy, false
  batch_action :check, :confirm => I18n.t("admin.confirm") do |selection|
    Deal.unscoped.find(selection).each {|deal| deal.check! if deal.may_check?}
    redirect_to collection_path, :notice => "操作成功!"
  end
  
  batch_action :accept, :confirm => I18n.t("admin.confirm") do |selection|
    Deal.unscoped.find(selection).each {|deal| deal.accept! if deal.may_accept?}
    redirect_to collection_path, :notice => "操作成功!"
  end
  
  batch_action :publish, :confirm => I18n.t("admin.confirm") do |selection|
    Deal.unscoped.find(selection).each {|deal| deal.publish! if deal.may_publish?}
    redirect_to collection_path, :notice => "操作成功!"
  end
  
  batch_action :reject, :confirm => I18n.t("admin.confirm") do |selection|
    Deal.unscoped.find(selection).each {|deal| deal.reject! if deal.may_reject?}
    redirect_to collection_path, :notice => "操作成功!"
  end
  
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
      f.input :display_title, as: :ckeditor, :input_html => { :ckeditor => {:language => "zh-cn"} }
    end
    
    f.inputs "Body" do
      f.input :display_body, as: :ckeditor, :input_html => { :ckeditor => {:language => "zh-cn"} }
    end
    
    f.inputs "Extra Body" do
      f.input :display_body_extra, as: :ckeditor, :input_html => { :ckeditor => {:language => "zh-cn"} }
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
    selectable_column
    column :pictures do |deal|
      link_to(image_tag(deal.pictures.first.image.url(:tiny)), admin_deal_path(deal)) if deal.pictures.any?
    end
    column :state do |deal|
      if deal.unchecked?
        status_tag "待审核"
      elsif deal.checking?
        status_tag "审核中", :warning
      elsif deal.accepted?
        status_tag "通过", :warning
      elsif deal.published?
        status_tag "发布", :ok
      elsif deal.deprecated?
        status_tag "过期", :warning
      elsif deal.rejected?
        status_tag "丢弃", :error
      end
    end
    column :title do |deal|
      link_to deal.short_title, admin_deal_path(deal)
    end
    column :created_at
    column :updated_at
    default_actions
  end
  
  # index :as => :grid do |deal|
#     link_to(image_tag(deal.pictures.first.try(:image).try(:url(:tiny))), admin_deal_path(deal))
#   end
  
  controller do
    def scoped_collection
      Deal.unscoped
    end
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
