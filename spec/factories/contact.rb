FactoryGirl.define do
  factory :contact do
    association :user, :as_player
  end
end
