class AddStatusToPlayers < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :status, :integer, default: 0
  end
end
