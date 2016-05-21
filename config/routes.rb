Rails.application.routes.draw do
  devise_for :users
  root to: "static#home"

  resources :articles
  resources :categories
end
