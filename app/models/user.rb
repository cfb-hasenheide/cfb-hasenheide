class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { fan: 0, player: 1, admin: 2 }

  validates_presence_of :username

  def self.players
    where(role: [1, 2])
  end

  def self.didnt_reply_to_event(event_id)
    ids = User.players.pluck(:id) - Reply.where(event_id: event_id).pluck(:user_id)
    User.where(id: ids)
  end
end
