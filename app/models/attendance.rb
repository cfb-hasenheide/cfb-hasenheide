class Attendance < ActiveRecord::Base
  belongs_to :attendance_list
  belongs_to :player

  validates :attendance_list, :player, presence: true
  validates :player_id, uniqueness: { scope: :attendance_list_id }

  enum status: { pending: 0, yes: 1, waiting: 2, maybee: 3, watch: 4, no: 5 }

  before_save :check_yes_maximum
  after_save :check_for_waiting

  delegate :nickname, to: :player, prefix: true

  private

  def check_yes_maximum
    return unless status_changed? && yes?
    return if attendance_list.yes_count < attendance_list.maximum

    self.status = 'waiting'
  end

  def check_for_waiting
    return unless status_changed_from_yes && one_spot_left

    waiting = attendance_list.attendances.waiting.order(updated_at: :asc).first

    waiting.update(status: :yes) if waiting.present?
  end

  def status_changed_from_yes
    status_changed? && (status_was == 'yes' || status_was == :yes)
  end

  def one_spot_left
    attendance_list.yes_count == attendance_list.maximum - 1
  end
end
