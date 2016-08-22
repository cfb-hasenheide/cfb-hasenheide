FactoryGirl.define do
  factory :function do
    association :user, factory: :user
    association :role, factory: :role
    assumed_at Date.today + 10

    trait :past do
      assumed_at Date.today - 10.day
      vacated_at Date.today - 6.day
    end

    trait :current do
      assumed_at Date.today
      vacated_at Date.today + 15
    end

    trait :future do
      assumed_at Date.today + 10
    end
  end
end
