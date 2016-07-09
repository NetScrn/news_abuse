Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  scope "(:locale)", locale: /ru|en/ do
    devise_for :users

    root to: redirect("/ru/home")
    get "/home" => "static#home"

    resources :articles, except: [:index] do
      resources :comments, only: [:create, :destroy] do
        member do
          get :subcomment
          post :subcomment, action: :create_subcomment
        end
      end
    end
    resources :categories, only: [:new, :index, :show]
  end
end
