class CreateAddresses < ActiveRecord::Migration[5.0]
  def up
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :zipcode, null: false
      t.string :city, null: false
      t.references :addressable, polymorphic: true, index: true
      t.float :longitude
      t.float :latitude

      t.timestamps
    end

    execute <<-SQL
      INSERT INTO addresses(addressable_id, street, zipcode, city)
      SELECT players.user_id, players.street, players.zipcode, players.city
      FROM players
    SQL

    execute <<-SQL
      UPDATE addresses SET addressable_type='User'
    SQL

    remove_column :players, :street
    remove_column :players, :zipcode
    remove_column :players, :city
  end


  def down
    add_column :players, :street, :string
    add_column :players, :zipcode, :string
    add_column :players, :city, :string

    execute <<-SQL
      UPDATE players
      SET street=addresses.street,
          city=addresses.city,
          zipcode=addresses.zipcode
      FROM addresses
      WHERE players.user_id = addresses.addressable_id
    SQL

    drop_table :addresses
  end
end
