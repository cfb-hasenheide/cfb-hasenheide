class AddPlayerPassNeededToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :player_pass_needed, :boolean, null: false, default: false
  end
end
