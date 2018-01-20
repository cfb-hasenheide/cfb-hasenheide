class AddEventIdUserIdUniqueIndexToReplies < ActiveRecord::Migration[4.2]
  def change
    add_index :replies, [:event_id, :user_id], unique: true
  end
end
