class RenameAvatarUrlToAvatar < ActiveRecord::Migration
  def change
    rename_column :user_profiles, :avatar_url, :avatar
  end
end
