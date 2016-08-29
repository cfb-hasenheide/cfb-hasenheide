FactoryGirl.define do
  factory :member do
    sequence(:identifier) { |n| "123coolIdInHerexxxx#{n}" }
    association :user, :as_player
  end
end
