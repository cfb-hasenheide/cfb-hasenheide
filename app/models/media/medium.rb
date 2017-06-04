class Medium < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :user

  validates :file, :type, presence: true
end
