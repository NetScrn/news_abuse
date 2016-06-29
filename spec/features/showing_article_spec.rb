require 'rails_helper'

RSpec.describe 'Users can see the article' do
  let!(:user)    { create(:user) }
  let!(:category) { create(:category) }
  let!(:article) { create(:article, author: user, categories: [category]) }

  before(:each) do
    visit article_path("en", article)
  end

  it 'should correctly display the article' do
    expect(page).to have_content article.title
    expect(page).to have_content article.body
    expect(page).to have_content article.categories.first.name
  end
end
