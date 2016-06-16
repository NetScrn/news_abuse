require 'rails_helper'

RSpec.describe 'Users can create article' do

  it 'should create valid article' do
    visit articles_path("en")
    click_link "New Article"

    fill_in "Title", with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    fill_in "redactor-tf", with: Faker::Lorem.paragraphs(6).join(" ")

    click_button "Create Article"

    expect(page).to have_content "Article has been successfuly created."
    expect(page).to have_content "Ruby on Rails is awesome!"
  end

  it 'should create valid article through category page' do
    category = create(:category)

    visit category_path("en", category)
    click_link "New Article"

    fill_in "Title", with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    fill_in "redactor-tf", with: Faker::Lorem.paragraphs(6).join(" ")

    click_button "Create Article"

    within(".category-tags") do
      expect(page).to have_content "Programming"
    end
    expect(page).to have_content "Article has been successfuly created."
    expect(page).to have_content "Ruby on Rails is awesome!"
  end
end
