class CreateAttendeesLists < ActiveRecord::Migration
  def change
    create_table :attendees_lists do |t|
      t.references :attendable, polymorphic: true, index: true
      t.boolean :open, null: false, default: false
      t.integer :minimum, null: false, default: 7
      t.integer :maximum, null: false, default: 11
    end
  end
end
