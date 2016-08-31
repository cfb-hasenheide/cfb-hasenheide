class MovePersonalInformationFromContactToMember < ActiveRecord::Migration[5.0]
  def up
    add_column :members, :firstname, :string
    add_column :members, :lastname, :string
    add_column :members, :date_of_birth, :date
    add_column :members, :place_of_birth, :string

    Contact.all.each do |contact|
      Member.find_by(user_id: contact.user_id).update(
        firstname: contact.firstname,
        lastname: contact.lastname,
        date_of_birth: contact.date_of_birth,
        place_of_birth: contact.place_of_birth
      )
    end

    remove_column :contacts, :firstname
    remove_column :contacts, :lastname
    remove_column :contacts, :date_of_birth
    remove_column :contacts, :place_of_birth
  end

  def down
    add_column :contacts, :firstname, :string
    add_column :contacts, :lastname, :string
    add_column :contacts, :date_of_birth, :date
    add_column :contacts, :place_of_birth, :string

    Member.all.each do |member|
      Contact.find_by(user_id: member.user_id).update(
        firstname: member.firstname,
        lastname: member.lastname,
        date_of_birth: member.date_of_birth,
        place_of_birth: member.place_of_birth
      )
    end

    remove_column :members, :firstname
    remove_column :members, :lastname
    remove_column :members, :date_of_birth
    remove_column :members, :place_of_birth
  end
end
