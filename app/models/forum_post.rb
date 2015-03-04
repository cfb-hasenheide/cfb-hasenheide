class ForumPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :forum_thread

  validates :comment, :user_id, :forum_thread_id, presence: true
end
