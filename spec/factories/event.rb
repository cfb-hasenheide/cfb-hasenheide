FactoryGirl.define do
  factory :event do
    association :club_team, factory: [:team, :club]
    address 'Kreuzberg, Berlin'
    datetime Time.zone.now
    home true
    name 'Eventname'
    type 'Other'

    trait :other do
      type 'Other'
      name 'Other Event'
    end

    trait :past do
      sequence(:datetime) { |n| Time.zone.now - n.day }
    end

    trait :future do
      sequence(:datetime) { |n| Time.zone.now + n.day }
    end
  end
end
