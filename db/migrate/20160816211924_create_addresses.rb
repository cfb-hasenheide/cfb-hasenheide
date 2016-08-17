class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.integer :zipcode, null: false
      t.references :addressable, polymorphic: true, index: true
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
