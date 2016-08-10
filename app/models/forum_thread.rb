class ForumThread < ApplicationRecord
  belongs_to :user

  validates :topic, :comment, :user_id, presence: true
end
