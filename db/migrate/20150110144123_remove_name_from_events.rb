class RemoveNameFromEvents < ActiveRecord::Migration[4.2]
  def change
    remove_columns :events, :name
  end
end
