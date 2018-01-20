class RemoveMinimumMaximumAndReplyableFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_column :events, :minimum, :integer
    remove_column :events, :maximum, :integer
    remove_column :events, :replyable, :boolean, null: false, default: false
  end
end
