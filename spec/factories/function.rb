FactoryGirl.define do
  factory :function do
    association :user, factory: :user
    association :role, factory: :role
    assumed_at DateTime.now - 10.day

    trait :in_past do
      vacated_at DateTime.now - 6.day
    end

    trait :current_function do
      vacated_at DateTime.now + 6.day
    end
  end
end
