Rails.application.routes.draw do
  devise_for :users
  root to: "static#home"

  resources :articles, only: [:index, :show]
  resources :categories, only: [:index, :show]
end
