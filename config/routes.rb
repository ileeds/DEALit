Rails.application.routes.draw do
  resources :users
  resources :products
  root 'users#index'
end
