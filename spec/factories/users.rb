FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name}
    email { Faker::Internet.email }
    password 'password'
    confirmed_at { Time.now }

    trait :admin do
      admin true
    end

    trait :archived do
      archived_at { Time.now }
    end

    factory :user_with_articles do
      transient do
        articles_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:article, evaluator.articles_count, author: user)
      end
    end
  end
end
