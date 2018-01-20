class RenameEventsKindToType < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :type, :string
    remove_column :events, :kind, :integer
  end
end
