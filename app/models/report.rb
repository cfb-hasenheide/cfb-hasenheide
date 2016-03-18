class Report < ActiveRecord::Base
  belongs_to :event

  validates :event_id, presence: true, uniqueness: true

  enum result: { lost: 0, drew: 1, won: 3 }

  before_save :set_result, if: :final_score_changed?

  def final_score
    return "#{club_final_score} : #{rival_final_score}" if event.home?
    "#{rival_final_score} : #{club_final_score}"
  end

  def final_score_present?
    club_final_score.present? && rival_final_score.present?
  end

  private

  def final_score_changed?
    club_final_score_changed? || rival_final_score_changed?
  end

  def set_result
    self.result = nil && return unless final_score_present?

    if club_final_score > rival_final_score
      self.result = 'won'
    elsif club_final_score < rival_final_score
      self.result = 'lost'
    else
      self.result = 'drew'
    end
  end
end
