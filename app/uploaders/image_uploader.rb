# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  #include Ckeditor::Backend::CarrierWave
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  #storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end 

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
  
  version :large do
      process :resize_to_limit => [650,650]
  end

  version :medium do
    process :resize_to_limit => [194,194]
  end

  version :thumb do
      process :resize_to_limit => [122,122]
  end

  version :tiny do
      process :resize_to_limit => [48,48]
  end 
  
  version :small do
      process :resize_to_limit => [80,80]
  end 
  
  version :avatar64 do
      process :resize_to_limit => [64,64]
  end 
  
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
