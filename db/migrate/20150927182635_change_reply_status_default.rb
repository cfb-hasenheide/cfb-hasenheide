class ChangeReplyStatusDefault < ActiveRecord::Migration
  def change
    change_column :replies, :status, :integer, null: false, default: 0
  end
end
