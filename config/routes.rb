Rails.application.routes.draw do

  root "static_pages#home"

  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "signin" => "sessions#new"
  post "signin" => "sessions#create"
  delete "signout" => "sessions#destroy"
  get "users" => "users#index"
  get "signup" => "users#new"

  resource :words, only: [:index]
  resources :users
end
