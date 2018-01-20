class AddMinimumAndMaximumToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :minimum, :integer
    add_column :events, :maximum, :integer
  end
end
