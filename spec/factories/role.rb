FactoryGirl.define do
  factory :role do
    sequence(:name) { |n| "Awesome_#{n}" }
  end
end
