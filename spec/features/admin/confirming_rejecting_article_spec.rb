require 'rails_helper'

RSpec.feature "An admin can confirm and reject an article", js: true do
  let(:user) { create(:user) }
  let!(:unconfirmed_article) { create(:article, :unconfirmed, author: user)}
  let(:admin_user) { create(:user, :admin) }

  before(:each) do
    login_as admin_user
    visit admin_articles_path("en")
  end

  it "confirm" do
    click_link "Confirm"
    expect(page).to have_content "Article has been confirmed"
  end

  it "reject" do
    click_link "Reject"
    expect(page).to have_content "Article has been rejected and deleted"
  end
end
