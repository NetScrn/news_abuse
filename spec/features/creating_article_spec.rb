require 'rails_helper'

RSpec.describe 'Users can create article' do
  let(:category) { create(:category) }
  let(:other_category) { create(:category) }
  
  it 'authenticated should create valid article', js: true do
    login_as create(:user)
    visit categories_path("en")

    click_link "New Article"

    body = Faker::Lorem.paragraphs(6).join(" ")

    fill_in "Title",       with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    page.execute_script("document.getElementById('redactor-tf').value = '#{body}'");
    within("#categories")
    select(category.name,       from: "1")
    click_button "Add One More Category"
    select(other_category.name, from: "2")


    click_button "Create Article"

    expect(page).to have_content "Article has been successfuly created."
    expect(page).to have_content "Ruby on Rails is awesome!"
    expect(page).to have_content category.name
    expect(page).to have_content other_category.name
    expect(page).to have_content body
  end
end
