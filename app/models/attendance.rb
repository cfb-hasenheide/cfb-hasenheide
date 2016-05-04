class Attendance < ActiveRecord::Base
  belongs_to :attendance_list
  belongs_to :player

  validates :player_id, uniqueness: { scope: :attendance_list_id }

  enum status: { pending: 0, yes: 1, waiting: 2, maybee: 3, watch: 4, no: 5 }
end
