class AddForeignKeyUsersToMembers < ActiveRecord::Migration[5.0]
  def up
    Member.find_each do |member|
      member.destroy if member.user.nil?
    end

    add_foreign_key :members, :users
  end

  def down
    remove_foreign_key :members, :users
  end
end
