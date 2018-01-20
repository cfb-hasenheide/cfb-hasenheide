class AddAdminAndPlayerAndPlayerPassToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
    add_column :users, :player, :boolean, null: false, default: false
    add_column :users, :player_pass, :boolean, null: false, default: false

    add_index :users, :admin
    add_index :users, [:player, :player_pass]
  end
end
