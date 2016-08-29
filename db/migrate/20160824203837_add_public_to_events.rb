class AddPublicToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :public, :boolean, null: false, default: false

    Event.where(type: %w(CupMatch LeagueMatch)).update_all(public: true)
  end
end
