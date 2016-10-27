module ChartsHelper
  def player_counts_by_training_chart
    bar_chart player_counts_by_training_chart_path, label: 'Teilnehmer'
  end

  def training_counts_by_player_chart
    bar_chart training_counts_by_player_chart_path, label: 'Teilnahmen'
  end
end
