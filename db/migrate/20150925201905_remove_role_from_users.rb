class RemoveRoleFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :role, :integer, null: false, default: 0
  end
end
