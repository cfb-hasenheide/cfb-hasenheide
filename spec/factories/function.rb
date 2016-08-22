FactoryGirl.define do
  factory :function do
    association :user, factory: :user
    association :role, factory: :role
    assumed_at Time.zone.today + 10

    trait :past do
      assumed_at Time.zone.today - 10.days
      vacated_at Time.zone.today - 6.days
    end

    trait :current do
      assumed_at Time.zone.today
      vacated_at Time.zone.today + 15
    end

    trait :future do
      assumed_at Time.zone.today + 10
    end
  end
end
