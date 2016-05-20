require "rails_helper"

describe Article do
  it "is valid with title, short description" do
    article = Article.new(
      title: "Hello world!",
      description: "GoodBye")

    expect(article).to be_valid
  end

  it "is invalid without a title" do
    article = Article.new(title: nil)
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a short description" do
    article = Article.new(description: nil)
    article.valid?
    expect(article.errors[:description]).to include("can't be blank")
  end
end
