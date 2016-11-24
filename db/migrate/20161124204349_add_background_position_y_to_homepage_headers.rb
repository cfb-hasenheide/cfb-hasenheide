class AddBackgroundPositionYToHomepageHeaders < ActiveRecord::Migration[5.0]
  def change
    add_column :homepage_headers,
               :background_position_y,
               :integer,
               null: false,
               default: 0
  end
end
