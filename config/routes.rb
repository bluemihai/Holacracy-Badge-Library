Rails.application.routes.draw do
  resources :users
  resources :badge_nominations
  resources :badges
  resources :nomination_votes

  root to: 'visitors#about'
  get 'about' => 'visitors#about'
  get 'validations' => 'nomination_votes#index'
  get 'nominations' => 'badge_nominations#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
