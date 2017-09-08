class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.string :summary
      t.string :content
      t.boolean :public, null: false, default: false
      t.date :posted_on, null: false
      t.references :member, null: false

      t.timestamps
    end

    add_foreign_key :posts, :members
  end
end
