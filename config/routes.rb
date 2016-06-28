Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  scope "(:locale)", locale: /ru|en/ do
    devise_for :users

    root to: redirect("/ru/home")
    get "/home" => "static#home"

    resources :articles, except: [:index]
    resources :categories, only: [:new, :index, :show]
  end
end
