class Message < ActiveRecord::Base
  belongs_to :user

  validates :user, :content, presence: true
end
