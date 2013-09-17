class Ckeditor::Picture < Ckeditor::Asset
  if Rails.env.production?
    mount_uploader :data, ProductionImageUploader, :mount_on => :data_file_name
  else
    mount_uploader :data, ImageUploader, :mount_on => :data_file_name
  end
  
  def url_content
    url(:large)
  end
end
