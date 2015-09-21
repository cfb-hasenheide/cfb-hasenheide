class AddPlayerPassNeededToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :player_pass_needed, :boolean, null: false, default: false
  end
end
