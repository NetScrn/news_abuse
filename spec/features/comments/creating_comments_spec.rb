require 'rails_helper'

RSpec.describe 'Comments creating' do
  let(:user)    { create(:user) }
  let(:article) { create(:article, author: user) }
  let(:comment) { create(:comment, article: article)}

  it 'unauthenticated user can create comment' do
    visit article_path("en", article)

    within(".comments-container") do
      fill_in "Content", with: "Hello from the other side"
      click_button "Create Comment"
    end


    within("#comments") do
      expect(page).to have_content "Guest"
      expect(page).to have_content "Hello from the other side"
    end
  end

  it 'authenticated user can create comment' do
    login_as user

    visit article_path("en", article)

    within(".comments-container") do
      fill_in "Content", with: "Hello from the other side"
      click_button "Create Comment"
    end


    within("#comments") do
      expect(page).to have_content user.username
      expect(page).to have_content "Hello from the other side"
    end
  end

  it 'user can comment a comment', js: true do
    comment
    visit article_path("en", article)

    within "#comment-#{comment.id}" do
      click_link "Reply"
      fill_in "Content", with: "I must've called a thousand times"
      click_button "Create Comment"
    end

    within "#comment-#{comment.id + 1}" do
      expect(page).to have_content "I must've called a thousand times"
    end

  end

end
