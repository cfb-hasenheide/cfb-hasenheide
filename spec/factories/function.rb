FactoryGirl.define do
  factory :function do
    user
    role
    assumed_on Time.zone.today + 10

    trait :past do
      assumed_on Time.zone.today - 10.days
      vacated_on Time.zone.today - 6.days
    end

    trait :current do
      assumed_on Time.zone.today
      vacated_on Time.zone.today + 15
    end

    trait :future do
      assumed_on Time.zone.today + 10
    end
  end
end
