Rails.application.routes.draw do
  resources :badge_set_entries
  resources :badge_sets
  resources :comp_tiers
  resources :users
  resources :badge_nominations
  resources :badges do
    member { get :propose, :accept, :reject }
  end
  resources :nomination_votes

  root to: 'badges#index'
  get 'about' => 'visitors#about'
  get 'validations' => 'nomination_votes#index'
  get 'nominations' => 'badge_nominations#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
