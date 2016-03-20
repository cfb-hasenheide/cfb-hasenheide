FactoryGirl.define do
  factory :event do
    address 'Kreuzberg, Berlin'
    datetime Time.zone.now
    home true
    maximum 11
    minimum 7
    name 'Eventname'
    type 'Other'

    trait :other do
      type 'Other'
      name 'Other Event'
      association :club_team, factory: [:team, :club]
    end
  end
end
