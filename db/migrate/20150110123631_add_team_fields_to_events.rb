class AddTeamFieldsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :home_team, :string
    add_column :events, :home_team_id, :int

    add_column :events, :away_team, :string
    add_column :events, :away_team_id, :int
  end
end
