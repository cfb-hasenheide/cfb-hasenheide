class AddDescriptionAndKindToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :description, :string
    add_column :teams, :kind, :integer
  end
end
