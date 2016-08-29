class AddMembershipForAllPlayers < ActiveRecord::Migration[5.0]
  def up
    Player.all.each do |p|
      Member.create( user_id: p.user_id) unless p.user.member
    end
  end

  def down
    Member.where(identifier: nil).delete_all
  end
end
