class AddSlugToEvents < ActiveRecord::Migration
  def up
    add_column :events, :slug, :string

    Event.find_each(&:save)

    change_column_null :events, :slug, false

    add_index :events, :slug, unique: true
  end

  def down
    remove_column :events, :slug, :string
  end
end
