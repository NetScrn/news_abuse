FactoryGirl.define do
  factory :article do
    title "RoR Tutorial"
    description "Really good RoR tutorial bla bla bla"
    body { Faker::Lorem.paragraphs(6).join(" ") }
    categories [Category.new(name: "OpaOpa OPa")] # dont know how to do this shit good, becouse of that, rake taks and broke


    factory :invalid_article do
      title nil
      description nil
      body nil
    end
  end
end
