FactoryGirl.define do
  factory :player do
    sequence(:nickname) { |n| "nick_name_cater_#{n}" }
    association :user, factory: :user, username: 'User'
  end
end
