class Function < ApplicationRecord
  belongs_to :user
  belongs_to :role

  before_save :check_existing_function

  validates :user_id, presence: true
  validates :role_id, presence: true
  validates :assumed_on, presence: true

  delegate :username, to: :user
  delegate :name, to: :role

  def self.current
    where('vacated_on > ? OR vacated_on is NULL AND assumed_on <= ?',
          Time.zone.today, Time.zone.today)
  end

  private

  def check_existing_function
    @same_functions = Function.where.not(id: id)
                              .where(role: role.id, user: user)
    unless creatable?
      errors[:vacated_on] << 'Role for user exists'
      throw(:abort)
    end
  end

  def creatable?
    return false unless correct_time_order?
    return false if exact_same?
    return false if endless_functions_overlapping?
    return false if inside_existing_function?
    return false if overlapping?
    true
  end

  def exact_same?
    @same_functions.where(user: user, role: role,
                          assumed_on: assumed_on, vacated_on: vacated_on).any?
  end

  def correct_time_order?
    return true if vacated_on.nil?
    vacated_on > assumed_on
  end

  def endless_functions_overlapping?
    only_endless? || existing_endless_before?
  end

  def only_endless?
    endless_functions = @same_functions.where('vacated_on = ?', nil)
    endless_functions.any? && vacated_on.nil?
  end

  def existing_endless_before?
    endless_functions = @same_functions.where('vacated_on = ?', nil)
    endless_functions.where('assumed_on <= ?', vacated_on).any?
  end

  def inside_existing_function?
    inside? || surrounding?
  end

  def inside?
    @same_functions.where('assumed_on <= ? and vacated_on >= ?',
                          assumed_on, vacated_on).any?
  end

  def surrounding?
    @same_functions.where('assumed_on >= ? and vacated_on <= ?',
                          assumed_on, vacated_on).any?
  end

  def overlapping?
    return true if @same_functions.where('assumed_on <= ? and vacated_on >= ?',
                                         assumed_on, vacated_on).any?
    return true if @same_functions.where('assumed_on >= ? and vacated_on <= ?',
                                         assumed_on, vacated_on).any?
    false
  end
end
