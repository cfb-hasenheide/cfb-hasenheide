class CreateMedia < ActiveRecord::Migration[5.0]
  def change
    create_table :media do |t|
      t.string :type, null: false
      t.string :file, null: false
      t.text :description
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
