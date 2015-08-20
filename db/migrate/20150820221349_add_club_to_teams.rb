class AddClubToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :club, :boolean
  end
end
