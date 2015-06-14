Rails.application.routes.draw do
  resources :users
  resources :badges
  resources :badge_nominations
  resources :nomination_votes

  root to: 'visitors#about'
  get 'about' => 'visitors#about'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
