class AddEventIdUserIdUniqueIndexToReplies < ActiveRecord::Migration
  def change
    add_index :replies, [:event_id, :user_id], unique: true
  end
end
