class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :user_id, null: false
      t.string :nickname, null: false
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :place_of_birth
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :phone1
      t.string :phone2
      t.string :club_email
      t.string :membership_number
      t.date :member_since
      t.date :member_until
      t.boolean :player_pass
      t.string :player_pass_number
      t.date :eligible_to_play_since
      t.integer :jersey_number
      t.string :jersey_name
    end

    add_index :players, :jersey_number, unique: true
    add_index :players, :user_id, unique: true
  end
end
