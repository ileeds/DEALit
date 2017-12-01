Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :searches
  resources :comments
  resources :notifications
  resources :galleries
  resources :photos
  resources :offers
  resources :options
  resources :users
  resources :homes do
    resources :reviews
  end
  resources :conversations do
    resources :messages
  end
  resources :home_steps

  root   'homes#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create_omni'
  get 'auth/failure', to: redirect('/')
end
