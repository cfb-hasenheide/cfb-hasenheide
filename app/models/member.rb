class Member < ApplicationRecord
  belongs_to :user
  has_one :player, dependent: :destroy
  has_one :contact, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
end
