class ChangeEventColumnNulls < ActiveRecord::Migration
  def change
    change_column_null :events, :address, false
    change_column_null :events, :datetime, false
    change_column_null :events, :home, false
    change_column_null :events, :maximum, false
    change_column_null :events, :minimum, false
    change_column_null :events, :name, false
    change_column_null :events, :type, false
  end
end
