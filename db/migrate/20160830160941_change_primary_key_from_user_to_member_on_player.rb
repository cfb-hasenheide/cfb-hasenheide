class ChangePrimaryKeyFromUserToMemberOnPlayer < ActiveRecord::Migration[5.0]
  def up
    add_reference :players, :member, foreign_key: true

    Player.all.each do |player|
      member = Member.find_by(user_id: player.user_id)
      player.update(member_id: member.id)
    end

    remove_reference :players, :user
  end

  def down
    add_reference :players, :user

    Player.all.each do |player|
      member = Member.find(player.member_id)
      player.update(user_id: member.user_id)
    end

    remove_reference :players, :member
  end
end
