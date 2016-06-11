require "rails_helper"

describe Article do
  it "is valid with title, short description" do
    article = build(:article,
      title: "Hello world!",
      description: Faker::Lorem.paragraph)

    expect(article).to be_valid
  end

  it "is invalid without a title" do
    article = build(:article, title: nil)
    article.valid?
    expect(article.errors[:title]).to include("Не может быть пустым")
  end

  it "is invalid without a short description" do
    article = build(:article, description: nil)
    article.valid?
    expect(article.errors[:description]).to include("Не может быть пустым")
  end
end
