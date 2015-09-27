class AddReplyableToEvents < ActiveRecord::Migration
  def change
    add_column :events, :replyable, :boolean, null: false, default: false
  end
end
