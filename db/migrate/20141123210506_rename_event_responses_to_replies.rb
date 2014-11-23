class RenameEventResponsesToReplies < ActiveRecord::Migration
  def change
    rename_table 'event_responses', 'replies'
  end
end
