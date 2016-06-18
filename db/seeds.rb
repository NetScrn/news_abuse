# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).


Category.destroy_all
Article.destroy_all
User.destroy_all

User.create(username: "admin", email: "viewer@ticketee.com", password: "password")

["Спорт", "Политика", "Технологии",
  "Музыка", "Мир", "Архитектура",
  "Программирование", "Металургия", "Машиностроение"].each do |cat|
  Category.create(name: cat)
end


if Rails.env.development?
  200.times do
    Article.create(title: Faker::Lorem.words(rand(1..3)).join(" ").capitalize,
                   description: Faker::Lorem.sentence(rand(1..3)),
                   body: Faker::Lorem.paragraphs(6).join(" "))
  end

  Article.all.each do |a|
    offset = rand(Category.count)
    Category.offset(offset).first.articles << a
  end
end
