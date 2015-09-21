class AddCurrentSeasonToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :current_season, :boolean, null: false, default: false
  end
end
