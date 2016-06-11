FactoryGirl.define do
  factory :article do
    title "RoR Tutorial"
    description "Really good RoR tutorial bla bla bla"
    body { Faker::Lorem.paragraphs(6).join(" ") }

    trait :article_with_cat do
      after(:build) do |article|
        article.categories << FactoryGirl.build(:category, name: "Programming")
      end
    end
  end
end
