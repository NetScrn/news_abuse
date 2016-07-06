FactoryGirl.define do
  factory :comment do
    content { Faker::Lorem.paragraph(rand(1..5)) }
    association :article, strategy: :build
    association :author, factory: :user

    factory :comment_with_owner do
      association :author, factory: :user, strategy: :build
    end
  end
end
