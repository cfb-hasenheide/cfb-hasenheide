class AddEventRefToLists < ActiveRecord::Migration
  def change
    add_reference :lists, :event, index: true
  end
end
