Rails.application.routes.draw do
  resources :nomination_votes
  get 'user_badges/new'
  get 'user_badges/create'

  resources :badges
  resources :badge_levels
  resources :user_badges
  resources :users

  root to: 'visitors#index'
  get 'about' => 'visitors#about'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
