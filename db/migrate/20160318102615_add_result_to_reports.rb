class AddResultToReports < ActiveRecord::Migration
  def change
    add_column :reports, :result, :integer
  end
end
