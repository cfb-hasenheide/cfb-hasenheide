class DropUserProfiles < ActiveRecord::Migration
  def change
    drop_table :user_profiles
  end
end
