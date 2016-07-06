require 'rails_helper'

RSpec.describe 'Comments deleting' do
  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }
  let(:article)    { create(:article, author: user) }
  let(:comment)    { create(:comment, article: article) }

  it 'article author can delete comment' do
    visit article_path("en", article)

    login_as user

    within(".comments-container") do
      fill_in "Content", with: "Hello from the other side"
      click_button "Create Comment"
    end

    within("#comments") do
      click_link "Delete"
    end

    expect(page).to_not have_content "Hello from the other side"
  end

  it 'author can delete his comment' do
    visit article_path("en", article)

    login_as other_user

    within(".comments-container") do
      fill_in "Content", with: "Hello from the other side"
      click_button "Create Comment"
    end

    within("#comments") do
      click_link "Delete"
    end

    expect(page).to_not have_content "Hello from the other side"
  end
end
