class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :minimum
      t.integer :maximum

      t.timestamps
    end
  end
end
