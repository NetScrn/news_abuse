require 'rails_helper'

RSpec.describe Category, type: :model do
  it "descending order by created_at of associated articles" do
    category = create(:category)
    article1 = create(:article, title: "First", description: Faker::Lorem.paragraph)
    article2 = create(:article, title: "Second", description: Faker::Lorem.paragraph)

    category.articles << article1
    category.articles << article2


    expect([category.articles[0],category.articles[1]]).to eql([article2, article1])
  end

  it "name value minimum 2 characters" do
    category = build(:category,
      name: "3")
    expect(category).to_not be_valid
  end
end
