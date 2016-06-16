Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  scope "(:locale)", locale: /ru|en/ do
    devise_for :users
    root to: "static#home"

    resources :articles, except: :destroy
    resources :categories, only: [:index, :show] do
      member do
        get 'new_article', to: 'articles#new'
      end
    end
  end
end
