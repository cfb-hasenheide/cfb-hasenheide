class Member < ApplicationRecord
  belongs_to :user
  has_one :contact, dependent: :destroy
  has_one :player, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  after_create :create_contact

  def self.without_player
    where.not(id: Player.pluck(:member_id))
  end

  def full_name
    "#{firstname} #{lastname}".presence || user.username
  end
end
