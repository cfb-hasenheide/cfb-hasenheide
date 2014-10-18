class AddMinimumAndMaximumToEvents < ActiveRecord::Migration
  def change
    add_column :events, :minimum, :integer
    add_column :events, :maximum, :integer
  end
end
