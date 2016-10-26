class CreateTrainings < ActiveRecord::Migration[5.0]
  def change
    create_table :trainings do |t|
      t.date :date, null: false
      t.integer :additional_count, null: false, default: 0
      t.string :additional_info
    end

    add_index :trainings, :date, unique: true
  end
end
