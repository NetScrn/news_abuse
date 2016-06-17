FactoryGirl.define do
  factory :category do
    name "Programming"

    factory :category_with_articles do
      transient do
        articles_count 5
      end

      after(:create) do |category, evaluator|
        create_list(:article, evaluator.articles_count, categories: [category])
      end
    end
  end
end
