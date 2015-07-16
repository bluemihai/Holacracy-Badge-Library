FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "TestUser#{n}@holacracyone.com" }

    trait :admin do
      role 'admin'
    end

  end
end
