class DropUserProfiles < ActiveRecord::Migration[4.2]
  def change
    drop_table :user_profiles
  end
end
