Rails.application.routes.draw do
  resources :assignments
  resources :roles
  resources :assignments
  resources :roles
  resources :badge_set_entries
  resources :badge_sets
  resources :comp_tiers
  resources :users
  resources :badge_nominations
  resources :badges do
    member { get :propose, :accept, :reject, :request_removal }
    collection { get :detailed }
  end
  resources :nomination_votes

  get ':controller/:action/:category'
  root to: 'badges#index'
  get 'about' => 'visitors#about'
  get 'help' => 'visitors#help'
  get 'validations' => 'nomination_votes#index'
  get 'nominations' => 'badge_nominations#index'
  get 'holders' => 'users#holders'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
