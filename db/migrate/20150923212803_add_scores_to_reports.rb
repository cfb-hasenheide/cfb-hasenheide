class AddScoresToReports < ActiveRecord::Migration
  def change
    add_column :reports, :club_final_score, :integer, limit: 1
    add_column :reports, :rival_final_score, :integer, limit: 1
    add_column :reports, :club_half_time_score, :integer, limit: 1
    add_column :reports, :rival_half_time_score, :integer, limit: 1
  end
end
