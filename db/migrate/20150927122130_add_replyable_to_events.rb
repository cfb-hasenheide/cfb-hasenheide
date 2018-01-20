class AddReplyableToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :replyable, :boolean, null: false, default: false
  end
end
