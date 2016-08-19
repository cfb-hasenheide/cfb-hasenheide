class Function < ApplicationRecord
  belongs_to :user
  belongs_to :role

  delegate :username, to: :user
  delegate :name, to: :role

  def self.for(user, role)
    create(user_id: user.id, role_id: role.id)
  end

  def self.current
    where('vacated_at > ? OR vacated_at is NULL AND assumed_at <= ?',
          DateTime.now, DateTime.now)
  end
end
