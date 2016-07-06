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

  context 'not author of comments and not author of articles cant delete comments' do
    it 'guest' do
      comment
      visit article_path("en", article)

      within("#comments") do
        expect(page).to have_content comment.content
        expect(page).to_not have_content "Delete"
      end
    end

    it "other user" do
      comment
      visit article_path("en", article)

      login_as other_user

      within("#comments") do
        expect(page).to have_content comment.content
        expect(page).to_not have_content "Delete"
      end
    end
  end
end
