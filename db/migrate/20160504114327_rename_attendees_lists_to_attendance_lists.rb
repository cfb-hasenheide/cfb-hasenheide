class RenameAttendeesListsToAttendanceLists < ActiveRecord::Migration
  def change
    rename_table :attendees_lists, :attendance_lists
  end
end
