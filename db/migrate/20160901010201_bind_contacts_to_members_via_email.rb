class BindContactsToMembersViaEmail < ActiveRecord::Migration[5.0]
  def change
     Contact.all.each do |contact|
      username = contact.club_email.split('@').first
      user = User.find_by(username: username)
      contact.update!(member_id: user.member.id)
    end
  end
end
