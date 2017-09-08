class Post < ApplicationRecord
  belongs_to :member

  mount_uploader :image, PostImageUploader
end
