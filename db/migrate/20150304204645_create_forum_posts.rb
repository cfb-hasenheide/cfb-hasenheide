class CreateForumPosts < ActiveRecord::Migration[4.2]
  def change
    create_table :forum_posts do |t|
      t.references :user, index: true
      t.references :forum_thread, index: true
      t.text :comment

      t.timestamps null: false
    end
    add_foreign_key :forum_posts, :users
    add_foreign_key :forum_posts, :forum_threads
  end
end
