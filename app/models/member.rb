class Member < ApplicationRecord
  belongs_to :user
  has_one :contact, dependent: :destroy
  has_one :player, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  after_create :create_contact, :create_default_player

  private

  def create_default_player
    self.create_player(nickname: user.username)
  end
end
