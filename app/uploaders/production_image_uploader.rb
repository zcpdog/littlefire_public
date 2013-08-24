# encoding: utf-8

class ProductionImageUploader < CarrierWave::Uploader::Base
  storage :upyun

  def store_dir
    "production/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def url(version_name="")
    @url ||= super({})
    return @url if version_name.blank?
    [@url, version_name].join("!") # 我这里在图片空间里面选用 ! 作为“间隔标志符”
  end
  
  # def default_url
#     # 搞一个大一点的默认图片取名 blank.png 用 FTP 传入图片空间，用于作为默认图片
#     # 由于有自动的缩略图处理，小图也不成问题
#     # Setting.upload_url 这个是你的图片空间 URL
#     "#{Setting.upload_url}/blank.png#{version_name}"
#   end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  def filename
    if super.present?
      "#{Time.zone.now.to_i}.#{file.extension.downcase}"
    end
  end

end
