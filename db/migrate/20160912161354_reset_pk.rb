class ResetPk < ActiveRecord::Migration[5.0]
  def change
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end
end
