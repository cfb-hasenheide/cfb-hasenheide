class DropReplies < ActiveRecord::Migration[4.2]
  def change
    drop_table :replies
  end
end
