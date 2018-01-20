class AddResultToReports < ActiveRecord::Migration[4.2]
  def change
    add_column :reports, :result, :integer
  end
end
