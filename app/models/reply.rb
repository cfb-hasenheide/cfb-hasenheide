class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_one :user_profile, through: :user

  after_save :check_for_waiting, if: :status_changed_from_yes
  before_save :check_yes_maximum

  validates :user_id, :event_id, :status, presence: true

  enum status: { pending: 0, yes: 1, waiting: 2, maybee: 3, watch: 4, no: 5 }

  scope :by_event, -> (event_id) { where(event_id: event_id) }

  def self.for_event_and_user(event, user)
    find_or_initialize_by(event_id: event, user_id: user)
  end

  private

  def check_yes_maximum
    return unless status_changed? && yes?

    self.status = 'waiting' if event.yes_count >= event.maximum
  end

  def status_changed_from_yes
    status_changed? && (status_was == 'yes' || status_was == :yes)
  end

  def check_for_waiting
    if event.yes_count < event.maximum
      waiting = Reply.by_event(event_id).waiting.order(updated_at: :asc).first
      waiting.update(status: :yes) if waiting.present?
    end
  end
end
