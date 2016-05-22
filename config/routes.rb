Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root to: "static#home"

  resources :articles, only: [:index, :show, :new, :create, :edit, :update]
  resources :categories, only: [:index, :show]
end
