class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: { fan: 0, player: 1, admin: 2 }

  validates_presence_of :username

  def self.players
    player + admin
  end
end
