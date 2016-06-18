require 'rails_helper'

RSpec.describe 'Users can create article' do
  it 'authenticated should create valid article' do
    login_as create(:user)
    visit categories_path("en")

    click_link "New Article"

    fill_in "Title", with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    fill_in "redactor-tf", with: Faker::Lorem.paragraphs(6).join(" ")

    click_button "Create Article"

    expect(page).to have_content "Article has been successfuly created."
    expect(page).to have_content "Ruby on Rails is awesome!"
  end

  it 'unauthenticated users cannot create articles' do
    visit categories_path("en")

    expect(page).to_not have_content "New Article"
  end
end
