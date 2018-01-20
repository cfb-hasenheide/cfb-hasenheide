class CreateForumThreads < ActiveRecord::Migration[4.2]
  def change
    create_table :forum_threads do |t|
      t.string :topic
      t.text :comment
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :forum_threads, :users
  end
end
