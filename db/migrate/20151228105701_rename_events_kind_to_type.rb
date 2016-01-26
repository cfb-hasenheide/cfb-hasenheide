class RenameEventsKindToType < ActiveRecord::Migration
  def change
    add_column :events, :type, :string
    remove_column :events, :kind, :integer
  end
end
