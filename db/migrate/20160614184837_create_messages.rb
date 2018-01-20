class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.references :user, index: true, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
