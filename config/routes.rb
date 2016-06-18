Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  scope "(:locale)", locale: /ru|en/ do
    devise_for :users
    root to: "static#home"

    resources :articles, except: [:index]
    resources :categories, only: [:index, :show]
  end
end
