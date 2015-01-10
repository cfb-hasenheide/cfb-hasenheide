class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :event_id
      t.text :content
      t.timestamps
    end

    add_index :reports, :event_id, unique: true
  end
end
