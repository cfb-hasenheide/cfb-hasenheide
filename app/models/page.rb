class Page < ApplicationRecord
  include FriendlyId
  friendly_id :slug, use: :slugged

  validates :slug, :header, :content, presence: true

  scope :published, -> { where(published: true) }
end
