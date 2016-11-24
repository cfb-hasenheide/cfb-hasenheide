class BackgroundImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  RESIZE_WIDTH = 940

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # process the image to be no wider than RESIZE_WIDTH while retaining the
  # proper aspect ratio and allowing any height.
  process resize_to_limit: [RESIZE_WIDTH, nil]

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
