Rails.application.routes.draw do
  resources :users
  resources :products
  root   'products#index'
  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
