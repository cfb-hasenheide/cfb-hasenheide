class ForumThread < ApplicationRecord
  belongs_to :user
  has_many :forum_posts, -> { order('created_at DESC') }

  validates :topic, :comment, :user_id, presence: true

  delegate :avatar_url, :nickname, to: :user, prefix: true

  # TODO: use ActiveRecord's counter_cache
  def forum_posts_count
    forum_posts.count
  end

  def newest_post
    forum_posts.first
  end
end
