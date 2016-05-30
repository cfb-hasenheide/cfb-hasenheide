class News < ActiveRecord::Base
  include Bootsy::Container

  validates :title, :content, presence: true
end
