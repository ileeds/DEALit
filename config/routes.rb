Rails.application.routes.draw do
  resources :searches
  resources :reviews
  resources :notifications
  resources :user_chats
  resources :chats
  resources :galleries
  resources :photos
  resources :offers
  resources :options
  resources :users
  resources :homes
  root   'homes#index'
  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
