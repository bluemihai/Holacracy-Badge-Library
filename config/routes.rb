Rails.application.routes.draw do
  resources :users, :badge_set_entries, :badge_sets, :comp_tiers, :badge_nominations, :nomination_votes
  resources :badges do
    member { get :propose, :accept, :reject, :request_removal }
    collection { get :detailed }
  end

  # for attention points app
  resources :assignments
  resources :roles do
    member { get :assign }
  end

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
