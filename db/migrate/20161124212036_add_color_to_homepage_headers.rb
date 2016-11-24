class AddColorToHomepageHeaders < ActiveRecord::Migration[5.0]
  def change
    add_column :homepage_headers, :color, :string, null: false, default: '#ffffff'
  end
end
