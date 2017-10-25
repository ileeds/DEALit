Rails.application.routes.draw do
  get 'static_pages/home'

  get 'static_pages/help'

  get 'static_pages/about'

  get 'static_pages/contact'

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
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/searches', to: 'seaches#create'
end
