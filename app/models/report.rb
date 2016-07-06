class Report < ActiveRecord::Base
  belongs_to :event

  validates :event_id, presence: true, uniqueness: true
  validates :club_final_score,
            numericality: { greater_than_or_equal_to: :club_half_time_score },
            if: 'club_half_time_score.present?'
  validates :rival_final_score,
            numericality: { greater_than_or_equal_to: :rival_half_time_score },
            if: 'rival_half_time_score.present?'
  validates :possession,
            numericality: { greater_than_or_equal_to: 0,
                            less_than_or_equal_to: 100 },
            if: 'possession.present?'

  enum incident: { armchair_decision: 0,
                   called_off_club: 1,
                   called_off_rival: 2,
                   cancelled_due_weather: 3 }
  enum result: { lost: 0, drew: 1, won: 3 }
  enum turf: { artificial: 0, natural: 1, gravel: 2 }
  enum weather: { sunny: 0, cloudy: 1, rainy: 2, snowy: 3 }

  before_save :set_result_and_points, if: :final_score_changed?

  scope :no_content, -> { where(content: [nil, '']) }

  delegate :club_team_name, :home?, :rival_team_name, to: :event
  delegate :address, :datetime, :name, :type, to: :event, prefix: true

  def final_score
    score(:final)
  end

  def half_time_score
    score(:half_time)
  end

  def final_score_present?
    club_final_score.present? && rival_final_score.present?
  end

  private

  def score(type)
    scores = [send("club_#{type}_score"), send("rival_#{type}_score")]
    scores.reverse! unless home?
    scores.compact.join(' : ')
  end

  def final_score_changed?
    club_final_score_changed? || rival_final_score_changed?
  end

  def set_result_and_points
    self.result = nil && return unless final_score_present?

    self.result = if club_final_score > rival_final_score
                    'won'
                  elsif club_final_score < rival_final_score
                    'lost'
                  else
                    'drew'
                  end

    # NOTE set the integer presentation of result enum as points
    self.points = self[:result]
  end
end
