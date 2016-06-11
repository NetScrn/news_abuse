require 'rails_helper'

RSpec.describe Category, type: :model do
  it "it should has descending order by created_at of associated articles" do
    category = create(:category)
    article1 = create(:article, title: "First", description: Faker::Lorem.paragraph)
    article2 = create(:article, title: "Second", description: Faker::Lorem.paragraph)

    category.articles << article1
    category.articles << article2


    expect([category.articles[0],category.articles[1]]).to eql([article2, article1])
  end
end
