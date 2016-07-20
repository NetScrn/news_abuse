require 'rails_helper'

RSpec.feature "An admin can archive users" do
  let(:admin_user) { create(:user, :admin) }
  let(:user)       { create(:user) }

  before(:each) do
    login_as(admin_user)
  end

  scenario "successfully" do
    visit admin_user_path("en", user)
    click_link "Archive User"

    expect(page).to have_content "User has been archived"
    visit admin_user_path("en", user)
    expect(page).to have_content "Archived At: #{user.archived_at}"
  end

  scenario "but cannot archive themselves" do
    visit admin_user_path("en", admin_user)
    click_link "Archive User"

    expect(page).to have_content "You cannot archive youself!"
  end
end
