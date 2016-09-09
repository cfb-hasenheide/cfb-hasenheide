class CreateJoinTablePlayersTeams < ActiveRecord::Migration[5.0]
  def change
    create_join_table :players, :teams do |t|
      t.index [:team_id, :player_id], unique: true
      t.index [:player_id, :player_id], unique: true
    end
  end
end
