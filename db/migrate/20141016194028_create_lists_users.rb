class CreateListsUsers < ActiveRecord::Migration
  def change
    create_table :lists_users, id: false do |t|
      t.references :list
      t.references :user
    end
  end
end
