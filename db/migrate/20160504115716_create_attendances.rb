class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.references :attendance_list
      t.references :player
      t.integer :status

      t.timestamps
    end

    add_index :attendances, [:attendance_list_id, :player_id], unique: true
  end
end
