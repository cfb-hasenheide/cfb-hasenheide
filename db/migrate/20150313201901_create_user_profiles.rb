class CreateUserProfiles < ActiveRecord::Migration[4.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, index: {:unique=>true}
      t.string :alias
      t.string :avatar_url

      t.timestamps null: false
    end
    add_foreign_key :user_profiles, :users
  end
end
