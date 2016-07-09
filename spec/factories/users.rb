FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name}
    email { Faker::Internet.email }
    password 'password'

    trait :admin do
      admin true
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
