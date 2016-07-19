require 'rails_helper'

RSpec.describe 'Users can only see appropriate elements' do
  let!(:user)    { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:article) { create(:article, author: user) }

  describe 'article links on category#index' do
    it 'should be hidden for noauthorized users' do
      visit categories_path("en")
      expect(page).to_not have_link "New Article"
    end

    it 'should be visible for authorized users' do
      login_as user
      visit categories_path("en")
      expect(page).to have_link "New Article"
    end
  end

  describe 'article links on article#show' do
    it 'should be hidden for noauthorized users' do
      visit article_path("en", article)
      expect(page).to_not have_link "Update Article"
      expect(page).to_not have_link "Delete Article"
    end

    it 'should be hidden for not author users' do
      login_as other_user
      visit article_path("en", article)
      expect(page).to_not have_link "Update Article"
      expect(page).to_not have_link "Delete Article"
    end

    it 'should be visible for authorized users' do
      login_as user
      visit article_path("en", article)
      expect(page).to have_link "Update Article"
      expect(page).to have_link "Delete Article"
    end
  end

  describe 'admin visible elements' do
    before(:each) do
      login_as admin_user
      visit root_path
    end

    it 'should be visible admin section link' do
      expect(page).to have_link "Admin"
    end
  end
end
