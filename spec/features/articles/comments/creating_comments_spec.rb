require 'rails_helper'

RSpec.describe 'Comments creating' do
  let(:user)    { create(:user) }
  let(:article) { create(:article, author: user) }

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

end
