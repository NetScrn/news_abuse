require 'rails_helper'

RSpec.describe "Articles authors can update article" do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:other_category) { create(:category, name: "other_category") }
  let(:article) { create(:article, author: user, categories: [category]) }

  it "author update article with valid attributes", js: true do
    login_as user
    visit article_path("en", article)

    click_link "Update Article"

    body = Faker::Lorem.paragraphs(6).join(" ")

    fill_in "Title",       with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    page.execute_script("document.getElementById('redactor-tf').value = '#{body}'");

    within("#categories") do
      select(other_category.name, from: "category")
    end

    click_button "Create Article"

    expect(page).to have_content "Article has been successfuly updated."
    expect(page).to have_content "Ruby on Rails is awesome!"
    expect(page).to have_content other_category.name
    expect(page).to have_content body
  end

  it "author update article, with not specified categories they do not changes", js: true do
    login_as user
    visit article_path("en", article)

    click_link "Update Article"

    body = Faker::Lorem.paragraphs(6).join(" ")

    fill_in "Title",       with: "Ruby on Rails is awesome!"
    fill_in "Description", with: Faker::Lorem.paragraph
    page.execute_script("document.getElementById('redactor-tf').value = '#{body}'");

    click_link "Add Another Category"
    click_link "Add Another Category"

    click_button "Create Article"

    expect(page).to have_content "Article has been successfuly updated."
    expect(page).to have_content "Ruby on Rails is awesome!"
    expect(page).to have_content category.name
    expect(page).to have_content body
  end

  it "not author cannot update someone else's article", js: true do
    login_as other_user

    visit article_path("en", article)

    expect(page).to_not have_link "Update Article"
  end
end
