class Function < ApplicationRecord
  belongs_to :user
  belongs_to :role

  before_save :correct_time_order?
  before_save :check_overlapping_time

  delegate :username, to: :user
  delegate :name, to: :role

  def self.current
    where('vacated_on > ? OR vacated_on is NULL AND assumed_on <= ?',
          Time.zone.today, Time.zone.today)
  end

  private

  def correct_time_order?
    return true unless vacated_on
    throw(:abort) if vacated_on < assumed_on
  end

  def check_overlapping_time
    same_functions = Function.where(role: role.id, user: user)
                             .where('vacated_on > ?', assumed_on)
                             .where('assumed_on < ?', vacated_on)
                             .where.not(id: id)
    throw(:abort) if same_functions.any?
  end
end
