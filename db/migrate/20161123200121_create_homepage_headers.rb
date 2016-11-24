class CreateHomepageHeaders < ActiveRecord::Migration[5.0]
  def change
    create_table :homepage_headers do |t|
      t.boolean :active, null: false, default: false
      t.string :background_image
      t.string :heading, null: false
      t.string :text

      t.timestamps
    end
  end
end
