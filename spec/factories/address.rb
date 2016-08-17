FactoryGirl.define do
  factory :address do
    sequence(:street) { |n| "Awesome_street #{n}" }
    sequence(:zipcode) { |n| n + 10_000 }
    sequence(:city) { |n| "Hasentown#{n}" }
    association :addressable, factory: :user
  end
end
