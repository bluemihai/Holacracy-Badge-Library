FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "TestUser#{n}@example.com" }

    trait :admin do
      role 'admin'
    end

  end
end
