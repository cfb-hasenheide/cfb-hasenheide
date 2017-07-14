class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.references :event, null: false, foreign_key: true
      t.integer :minute, null: false
      t.integer :extra_time
      t.integer :club_score, null: false
      t.integer :rival_score, null: false
      t.boolean :club, null: false
      t.references :scorer, foreign_key: { to_table: :players }
      t.references :provider, foreign_key: { to_table: :players }
      t.text :comment
      t.references :reporter, null: false, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
