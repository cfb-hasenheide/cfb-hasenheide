class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username

  has_and_belongs_to_many :events, foreign_key: :ins
  has_and_belongs_to_many :events, foreign_key: :outs
  has_and_belongs_to_many :events, foreign_key: :waitees
  has_and_belongs_to_many :events, foreign_key: :maybees
end
