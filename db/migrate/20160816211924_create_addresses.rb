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

    say 'Import data Addresses'

    Player.all.each do |p|
      if (p.city && p.street && p.zipcode)
        Address.create(
          city: p.city,
          street: p.street,
          addressable: p.user,
          zipcode: p.zipcode
        )
      end
    end

    remove_column :players, :street
    remove_column :players, :zipcode
    remove_column :players, :city
  end


  def down
    add_column :players, :street, :string
    add_column :players, :zipcode, :string
    add_column :players, :city, :string

    say 'Move data back to player class'

    Address.all.each do |a|
      p = Player.find_by(user_id: a.addressable_id)
      p.update(
        city: a.city,
        street: a.street,
        zipcode: a.zipcode
      )
    end

    drop_table :addresses
  end
end
