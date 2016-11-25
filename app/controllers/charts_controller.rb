class ChartsController < ApplicationController
  def player_counts_by_training
    sql = <<-SQL
      SELECT t.date, (count(pt.*) + t.additional_count) as count
      FROM players_trainings pt
      RIGHT JOIN trainings t on t.id = pt.training_id
      GROUP BY t.id
      ORDER BY t.date DESC;
    SQL

    render json: ActiveRecord::Base.connection.select_rows(sql)
  end

  def training_counts_by_player
    sql = <<-SQL
      SELECT p.nickname, count(*) from players_trainings pt
      JOIN players p on p.id = pt.player_id
      GROUP BY p.id
      ORDER BY count(*) DESC, p.nickname;
    SQL

    render json: ActiveRecord::Base.connection.select_rows(sql)
  end
end
