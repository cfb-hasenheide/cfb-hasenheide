class AddHomeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :home, :boolean
  end
end
