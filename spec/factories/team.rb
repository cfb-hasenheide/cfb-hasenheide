FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "Team #{n}" }

    trait :club do
      club true
      sequence(:name) { |n| "Club Team #{n}" }
    end

    trait :rival do
      club false
      sequence(:name) { |n| "Rival Team #{n}" }
    end
  end
end
