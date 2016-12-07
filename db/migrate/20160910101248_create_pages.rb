class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :slug, null: false
      t.string :header, null: false
      t.string :subheader
      t.text :content, null: false
      t.boolean :public, null: false, default: false
      t.boolean :published, null: false, default: false

      t.timestamps
    end

    add_index :pages, :slug, unique: true
  end
end
