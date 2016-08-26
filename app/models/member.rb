class Member < ApplicationRecord
  belongs_to :user
  delegate :player, to: :user
end
