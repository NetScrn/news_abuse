FactoryGirl.define do
  factory :article do
    title "RoR Tutorial"
    description "Really good RoR tutorial bla bla bla"
    body { Faker::Lorem.paragraphs(6).join(" ") }
    categories [Category.create(name: "Category")]

    factory :invalid_article do
      title nil
      description nil
      body nil
    end
  end
end
