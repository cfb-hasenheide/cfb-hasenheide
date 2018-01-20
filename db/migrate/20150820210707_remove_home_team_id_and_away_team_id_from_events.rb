class RemoveHomeTeamIdAndAwayTeamIdFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :home_team_id, :integer
    remove_column :events, :away_team_id, :integer
  end
end
