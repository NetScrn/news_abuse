Rails.application.routes.draw do
  namespace :admin do
  get 'articles/index'
  end

  namespace :admin do
  get 'articles/confirm'
  end

  namespace :admin do
  get 'articles/edit'
  end

  namespace :admin do
  get 'articles/update'
  end

  namespace :admin do
  get 'articles/delete'
  end

  namespace :admin do
  get 'categores/index'
  end

  namespace :admin do
  get 'categores/create'
  end

  namespace :admin do
  get 'categores/delete'
  end

  namespace :admin do
  get 'users/new'
  end

  namespace :admin do
  get 'users/index'
  end

  namespace :admin do
  get 'users/create'
  end

  namespace :admin do
  get 'users/edit'
  end

  namespace :admin do
  get 'users/update'
  end

  namespace :admin do
  get 'users/archive'
  end

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
    end
  end
end
