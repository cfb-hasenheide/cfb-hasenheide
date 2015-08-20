class AddDescriptionAndKindToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :description, :string
    add_column :teams, :kind, :integer
  end
end
