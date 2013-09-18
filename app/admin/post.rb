ActiveAdmin.register Post do
  scope :started
  scope :finished
  scope :published
  menu :label => I18n.t("admin.post"), :priority => 2
  
  batch_action :destroy, false
  
  batch_action :finish, :confirm => I18n.t("admin.confirm") do |selection|
    Post.unscoped.find(selection).each {|post| post.finish! if post.may_finish?}
    redirect_to collection_path, :notice => "操作成功!"
  end
  
  batch_action :publish, :confirm => I18n.t("admin.confirm") do |selection|
    Post.unscoped.find(selection).each {|post| post.publish! if post.may_publish?}
    redirect_to collection_path, :notice => "操作成功!"
  end
  
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do  
      f.input :label
    end
    f.inputs "Categories" do
      f.input :categories, :as => :check_boxes
    end

    f.inputs "Title" do
      f.input :title, as: :ckeditor, :input_html => { :ckeditor => {:language => "zh-cn"} }
    end
    
    f.inputs "Body" do
      f.input :body, as: :ckeditor, :input_html => { :ckeditor => {:language => "zh-cn"} }
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
  
  show do |post|
    attributes_table do
      row :categories do
        post.categories.map{|category| category.name }.join(",")
      end
      row :tile do
        post.plain_text_title
      end
      row :body do 
        post.plain_text_body
      end
      row "Images" do
         ul do
          post.pictures.each do |pic|
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
    column :pictures do |post|
      link_to(image_tag(post.pictures.first.image.url(:tiny)), admin_post_path(post)) if post.pictures.any?
    end
    column :state do |post|
      if post.started?
        status_tag "开始"
      elsif post.finished?
        status_tag "完成", :warning
      elsif post.published?
        status_tag "发布", :ok
      end
    end
    column :title do |post|
      link_to post.short_title, admin_post_path(post)
    end
    column :created_at
    column :updated_at
    default_actions
  end
  
  controller do
    def scoped_collection
      Post.unscoped
    end
    def resource_params
      permitted_params = Array.new
      unless request.get?
        permitted_params.push params.require(:post).permit(:title, :body, :label_id,
          [pictures_attributes: [:image, :id, :_destroy]],:category_ids=>[])
      end
    end
  end
end
