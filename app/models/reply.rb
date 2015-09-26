class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :user_profile, through: :user

  # before_save :check_maximum_replies, if: :status_changed_to_yes

  validates :user_id, :event_id, :status, presence: true

  enum status: { yes: 0, no: 1, maybee: 2, waiting: 3, watch: 4 }

  scope :event, -> (event_id) { where(event_id: event_id) }

  def self.for_event_and_user(event, user)
    find_or_initialize_by(event_id: event, user_id: user)
  end

  private

  def status_changed_to_yes
    status_changed? && status == 'yes'
  end

  # # TODO: Is there any better name for me please?
  # def check_maximum_replies
  #   require 'pry'; binding.pry
  #   if event.yes_count + event.waiting_count >= event.maximum
  #     self.status = 'waiting'
  #   end
  # end
end
