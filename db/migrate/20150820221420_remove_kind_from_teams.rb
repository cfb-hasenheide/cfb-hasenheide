class RemoveKindFromTeams < ActiveRecord::Migration[4.2]
  def change
    remove_column :teams, :kind, :boolean
  end
end
