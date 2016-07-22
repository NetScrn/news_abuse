Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
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

    namespace :admin do
      root "application#index"

      resources :users, except: [:edit, :destroy] do
        member do
          patch :archive
          patch :restore
        end
      end

      resources :articles, only: [:index, :delete] do
        member do
          patch  :confirm
          delete :reject
        end
      end
    end
  end
end
