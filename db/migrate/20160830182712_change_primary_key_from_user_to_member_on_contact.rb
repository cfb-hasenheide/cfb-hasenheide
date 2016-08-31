class ChangePrimaryKeyFromUserToMemberOnContact < ActiveRecord::Migration[5.0]
  def up
    add_reference :contacts, :member, foreign_key: true

    Contact.all.each do |contact|
      member = Member.find_by(user_id: contact.user_id)
      contact.update(member_id: member.id)
    end

    remove_reference :contacts, :user
  end

  def down
    add_reference :contacts, :user

    Contact.all.each do |contact|
      member = Member.find(contact.member_id)
      contact.update(user_id: member.user_id)
    end

    remove_reference :contacts, :member
  end
end
