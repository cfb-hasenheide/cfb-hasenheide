FactoryGirl.define do
  factory :member do
    sequence(:identifier) { |n| "123coolIdInHerexxxx#{n}" }
    association :user

    trait :with_contact do
      association :contact
    end

    trait :with_player do
      association :player
    end

    trait :with_address do
      association :address
    end
  end
end
