class AddAddressToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :address, :string
  end
end
