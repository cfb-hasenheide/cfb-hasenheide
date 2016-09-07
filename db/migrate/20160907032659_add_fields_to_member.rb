class AddFieldsToMember < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :player_ideal, :string
    add_column :members, :personal_moment, :string
  end
end
