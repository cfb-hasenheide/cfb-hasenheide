class AddCurrentSeasonToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :current_season, :boolean, null: false, default: false
  end
end
