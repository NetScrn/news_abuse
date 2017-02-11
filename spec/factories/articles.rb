FactoryGirl.define do
  factory :article do
    title "RoR Tutorial"
    description "Really good RoR tutorial bla bla bla"
    body { Faker::Lorem.paragraphs(6).join(" ") }
    categories [Category.new(name: "OpaOpa OPa")] # must be commented out on migrations!
    confirmed_at { Time.now }

    trait :unconfirmed do
      confirmed_at nil
    end

    factory :invalid_article do
      title nil
      description nil
      body nil
    end
  end
end
