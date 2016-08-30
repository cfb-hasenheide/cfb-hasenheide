class Member < ApplicationRecord
  belongs_to :user
  has_one :player, dependent: :destroy
end
