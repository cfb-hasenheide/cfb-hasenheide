class ChangeReplyStatusDefault < ActiveRecord::Migration[4.2]
  def change
    change_column :replies, :status, :integer, null: false, default: 0
  end
end
