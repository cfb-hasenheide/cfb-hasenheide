class AddStatusToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :status, :integer, default: 0
  end
end
