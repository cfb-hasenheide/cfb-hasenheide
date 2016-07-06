class RemovePlayerAndPlayerPassFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :player, :boolean, null: false, default: false
    remove_column :users, :player_pass, :boolean, null: false, default: false
  end
end
