class CreateContacts < ActiveRecord::Migration[5.0]
  def up
    create_table :contacts do |t|
      t.references :user, foreign_key: true
      t.string :firstname
      t.string :lastname
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :phone1
      t.string :phone2
      t.string :club_email

      t.timestamps
    end

    Player.all.each do |p|
      Contact.create(
        club_email: p.club_email,
        date_of_birth: p.date_of_birth,
        firstname: p.first_name,
        lastname: p.last_name,
        phone1: p.phone1,
        phone2: p.phone2,
        place_of_birth: p.place_of_birth,
        user: p.user
      )
    end

    remove_column :players, :first_name
    remove_column :players, :last_name
    remove_column :players, :date_of_birth
    remove_column :players, :place_of_birth
    remove_column :players, :phone1
    remove_column :players, :phone2
    remove_column :players, :club_email
  end

  def down
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
    add_column :players, :date_of_birth, :date
    add_column :players, :place_of_birth, :string
    add_column :players, :phone1, :string
    add_column :players, :phone2, :string
    add_column :players, :club_email, :string

    Contact.all.each do |c|
      p = Player.find_by(user_id: c.user_id)
      p.update(
        club_email: c.club_email,
        date_of_birth: c.date_of_birth,
        firs_tname: c.firstname,
        last_name: c.lastname,
        phone1: c.phone1,
        phone2: c.phone2,
        place_of_birth: c.place_of_birth,
        user: c.user
      )
    end

    drop_table :contacts
  end
end
