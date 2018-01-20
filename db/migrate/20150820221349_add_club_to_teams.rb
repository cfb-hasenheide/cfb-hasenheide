class AddClubToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :club, :boolean
  end
end
