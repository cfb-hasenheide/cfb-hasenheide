class RenameAttendeesListsToAttendanceLists < ActiveRecord::Migration[4.2]
  def change
    rename_table :attendees_lists, :attendance_lists
  end
end
