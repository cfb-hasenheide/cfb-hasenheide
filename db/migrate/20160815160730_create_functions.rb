class CreateFunctions < ActiveRecord::Migration[5.0]
  def change
    create_table :functions do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :role, foreign_key: true
      t.date :assumed_on
      t.date :vacated_on

      t.timestamps
    end
  end
end
