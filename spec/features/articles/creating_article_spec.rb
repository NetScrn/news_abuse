require 'rails_helper'

RSpec.describe 'Users can create article' do
  let!(:category) { create(:category) }
  let!(:other_category) { create(:category, name: "Medicine") }
  let(:user) { create(:user) }
  before(:each) do
    login_as user
    visit categories_path("en")
    click_link "New Article"
  end

  it 'should create valid article', js: true do
    body = Faker::Lorem.paragraphs(6).join(" ")

    fill_in "Title",       with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    page.execute_script("document.getElementById('redactor-tf').value = '#{body}'");

    within("#categories") do
      select(category.name,       from: "category")
    end

    click_link "Add Another Category"

    within("#categories") do
      select(other_category.name, from: "category_2")
    end

    click_button "Create Article"

    expect(page).to have_content "Article has been successfuly created."
    expect(page).to have_content "Ruby on Rails is awesome!"
    within ".category-tags" do
      expect(page).to have_content category.name
      expect(page).to have_content other_category.name
    end
    expect(page).to have_content body
    expect(page).to have_content "Published by: #{user.username}"
  end

  it 'should does not create invalid article', js: true do
    click_link "Add Another Category"

    click_button "Create Article"

    expect(page).to have_content "Article has been not created."
  end
end
