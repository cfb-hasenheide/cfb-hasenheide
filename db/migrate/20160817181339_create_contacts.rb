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

      t.datetime :created_at, null: true
      t.datetime :updated_at, null: true
    end

    execute <<-SQL
      INSERT INTO contacts(user_id, firstname,
                  lastname, date_of_birth,
                  place_of_birth, phone1, phone2, club_email)
      SELECT players.user_id, players.first_name,
             players.last_name, players.date_of_birth,
             players.place_of_birth,
             players.phone1, players.phone2,
             players.club_email
      FROM players
    SQL

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

    execute <<-SQL
      UPDATE players
      SET first_name=contacts.firstname,
          last_name=contacts.lastname,
          date_of_birth=contacts.date_of_birth,
          place_of_birth=contacts.place_of_birth,
          phone1=contacts.phone1,
          phone2=contacts.phone2,
          club_email=contacts.club_email
      FROM contacts
      WHERE players.user_id = contacts.user_id
    SQL

    drop_table :contacts
  end
end
