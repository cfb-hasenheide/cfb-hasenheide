class Event < ActiveRecord::Base
  has_many :replies

  validates :name, :datetime, presence: true

  def yes_count
    replies.yes.count
  end
end
