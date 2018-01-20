class AddLegacyPasswordToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :legacy_password, :boolean
  end
end
