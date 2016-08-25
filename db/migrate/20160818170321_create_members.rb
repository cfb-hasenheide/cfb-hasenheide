class CreateMembers < ActiveRecord::Migration[5.0]
  def up
    create_table :members do |t|
      t.references :user, index: true
      t.string :identifier
      t.date :member_since
      t.date :member_until

      t.timestamps
    end

    Player.all.each do |p|
      unless (p.membership_number.blank?)
        Member.create(
          user_id: p.user_id,
          identifier: p.membership_number,
          member_since: p.member_since,
          member_until: p.member_until
        )
      end
    end

    remove_columns :players, :membership_number
    remove_columns :players, :member_since
    remove_columns :players, :member_until
  end

  def down
    add_column :players, :membership_number, :string
    add_column :players, :member_since, :date
    add_column :players, :member_until, :date

    Member.all.each do |m|
      p = Player.find_by(user_id: m.user_id)

      p.update(
        membership_number: m.identifier,
        member_since: m.member_since,
        member_until: m.member_until
      )
    end

    drop_table :members
  end
end
