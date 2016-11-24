class HomepageHeader < ApplicationRecord
  default_scope { order(active: :desc, updated_at: :desc) }

  validates :heading, presence: true

  mount_uploader :background_image, BackgroundImageUploader

  def self.active
    where(active: true).first
  end

  def activate
    currently_active = self.class.active
    currently_active.update(active: false) if currently_active.present?
    update(active: true)
  end

  def style
    "background-image: url(#{background_image_url}); " \
      "background-position: 0% #{background_position_y}%;"
  end
end
