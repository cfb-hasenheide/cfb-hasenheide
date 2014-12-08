class News < ActiveRecord::Base
  validates :title, :content, :internal, presence: true
end
