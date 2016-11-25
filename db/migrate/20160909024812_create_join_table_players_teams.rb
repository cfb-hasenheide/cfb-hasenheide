class CreateJoinTablePlayersTeams < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
        DROP TABLE IF EXISTS PLAYERS_TEAMS
    SQL
    create_join_table :players, :teams do |t|
      t.index [:team_id, :player_id], unique: true
      t.index [:player_id, :team_id], unique: true
    end
  end

  def down
    drop_table :players_teams
  end
end
