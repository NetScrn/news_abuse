require 'rails_helper'

RSpec.feature "An admin can restore archivd users" do
  let(:admin_user)    { create(:user, :admin) }
  let(:archived_user) { create(:user, :archived) }

  before(:each) do
    login_as(admin_user)
  end

  scenario "successfully" do
    visit admin_user_path("en", archived_user)
    click_link "Restore User"

    expect(page).to have_content "User has been restored"
    visit admin_user_path("en", archived_user)
    expect(page).to have_content "Archived: Not Archived"
  end
end
