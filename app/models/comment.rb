class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true

  def edited?
    updated_at > created_at
  end
end
