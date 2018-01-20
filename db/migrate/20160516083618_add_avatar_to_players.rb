class AddAvatarToPlayers < ActiveRecord::Migration[4.2]
  def change
    add_column :players, :avatar, :string
  end
end
