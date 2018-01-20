class RenameAvatarUrlToAvatar < ActiveRecord::Migration[4.2]
  def change
    rename_column :user_profiles, :avatar_url, :avatar
  end
end
