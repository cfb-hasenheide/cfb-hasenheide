class Video < Medium
  mount_uploader :file, VideoUploader
end
