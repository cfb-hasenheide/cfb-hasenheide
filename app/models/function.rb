class Function < ApplicationRecord
  belongs_to :user
  belongs_to :role

  before_save :correct_time_order?
  before_save :check_overlapping_time

  delegate :username, to: :user
  delegate :name, to: :role

  def self.current
    where('vacated_at > ? OR vacated_at is NULL AND assumed_at <= ?',
          Time.zoneTime.now, Time.zoneTime.now)
  end

  private

  def correct_time_order?
    return true unless vacated_at
    throw(:abort) if vacated_at < assumed_at
  end

  def check_overlapping_time
    same_functions = Function.where(role: role.id, user: user)
      .where('vacated_at > ?', assumed_at)
      .where('assumed_at < ?', vacated_at)
      .where.not(id: id)
    throw(:abort) if same_functions.any?
  end
end
