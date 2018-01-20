class AddColumnsToReports < ActiveRecord::Migration[4.2]
  def change
    add_column :reports, :annotation, :string
    add_column :reports, :captain_id, :integer
    add_column :reports, :corners_club, :integer
    add_column :reports, :corners_rival, :integer
    add_column :reports, :goalkeeper_id, :integer
    add_column :reports, :incident, :integer
    add_column :reports, :most_valuable_player_id, :integer
    add_column :reports, :points, :integer
    add_column :reports, :possession, :integer
    add_column :reports, :referee, :boolean
    add_column :reports, :referee_description, :string
    add_column :reports, :referee_name, :string
    add_column :reports, :reporter_id, :integer
    add_column :reports, :turf, :integer
    add_column :reports, :weather, :integer
  end
end
