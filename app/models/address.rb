class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :zipcode, :street, :city, presence: true
end
