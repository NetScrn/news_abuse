# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

Comment.destroy_all
Category.destroy_all
Article.destroy_all
User.destroy_all

User.create(username: "admin", email: "viewer@news-abuse.com", password: "password",
            confirmed_at: Time.now, admin: true)
User.create(username: "user", email: "user@news-abuse.com", password: "password",
            confirmed_at: Time.now)

%w(Спорт Политика Технологии
   Музыка Мир Архитектура
   Программирование Металургия
   Машиностроение Медицина).each do |cat|
  Category.create(name: cat)
end


200.times do
  Article.create(title: Faker::Lorem.words(rand(1..3)).join(" ").capitalize,
                 description: Faker::Lorem.sentence(rand(1..3)),
                 body: Faker::Lorem.paragraphs(6).join(" "),
                 categories: Category.all.sample(3),
                 author: User.first,
                 confirmed_at: [Time.now, nil].sample)
end
