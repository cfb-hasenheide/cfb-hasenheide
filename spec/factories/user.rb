FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password 'password'

    trait :as_player do
      association :player, factory: :player
    end
  end
end
