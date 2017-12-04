Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :notifications do
    member do
      get :mark_as_read
    end
  end

  resources :searches
  resources :comments
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
  resource :wizard do
    get :step1
    get :step2
    get :step3
    get :step4
    post :validate_step
  end

  root   'homes#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create_omni'
  get 'auth/failure', to: redirect('/')
end
