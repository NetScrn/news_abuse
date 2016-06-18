require 'rails_helper'

RSpec.describe 'Users can only see appropriate elements' do
  describe 'article links on category#index' do
    context '"New Article"' do
      it 'should be hedden for noautorized users' do
        visit categories_path("en")
        expect(page).to_not have_link "New Article"
      end

      it 'should be visible for authorized users' do
        login_as create(:user)
        visit categories_path("en")
        expect(page).to have_link "New Article"
      end
    end
  end
end
