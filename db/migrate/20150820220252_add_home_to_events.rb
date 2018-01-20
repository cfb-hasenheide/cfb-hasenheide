class AddHomeToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :home, :boolean
  end
end
