class AddTeamFieldsToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :home_team, :string
    add_column :events, :home_team_id, :int

    add_column :events, :away_team, :string
    add_column :events, :away_team_id, :int
  end
end
