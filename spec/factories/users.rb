FactoryGirl.define do
  factory :user do
    login { Faker::Name.first_name}
    email { Faker::Internet::Email }
    password 'password'

    # trait :admin do
    #   admin true
    # end
  end
end
