Rails.application.routes.draw do
  namespace :admin do
    root "categories#index"
    resources :words
    resources :users
    resources :categories
    resources :lessons
  end
  root "static_pages#home"
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "signup" => "users#new"
  resources :words, only: [:index]
  resources :users
  resources :categories
  resources :lessons
end
