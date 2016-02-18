module FriendlyIdAble
  extend ActiveSupport::Concern

  included do
    include FriendlyId
    friendly_id :name, use: :slugged

    def should_generate_new_friendly_id?
      name_changed? || super
    end
  end

  class_methods do
  end
end
