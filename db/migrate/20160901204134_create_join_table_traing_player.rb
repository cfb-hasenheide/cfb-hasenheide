class CreateJoinTableTraingPlayer < ActiveRecord::Migration[5.0]
  def change
    create_join_table :trainings, :players do |t|
      t.index [:training_id, :player_id]
      t.index [:player_id, :training_id]
    end
  end
end
