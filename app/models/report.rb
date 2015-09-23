class Report < ActiveRecord::Base
  belongs_to :event

  validates :event_id, presence: true

  def final_score
    return "#{club_final_score} : #{rival_final_score}" if event.home?
    "#{rival_final_score} : #{club_final_score}"
  end

  def final_score_present?
    club_final_score.present? && rival_final_score.present?
  end
end
