class Function < ApplicationRecord
  belongs_to :user
  belongs_to :role

  delegate :username, to: :user
  delegate :name, to: :role

  def self.for(user, role)
    create(user_id: user.id, role_id: role.id)
  end
end
