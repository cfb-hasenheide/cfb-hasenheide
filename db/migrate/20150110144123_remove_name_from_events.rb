class RemoveNameFromEvents < ActiveRecord::Migration
  def change
    remove_columns :events, :name
  end
end
