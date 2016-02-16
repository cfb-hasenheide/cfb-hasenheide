FactoryGirl.define do
  factory :event do
    type 'Other'
    minimum 7
    maximum 11
    datetime Time.zone.now
    address 'Kreuzberg, Berlin'

    trait :other do
      type 'Other'
      name 'Other Event'
      association :club_team, factory: [:team, :club]
    end
  end
end
