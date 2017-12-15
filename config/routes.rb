Rails.application.routes.draw do
  resources :followings
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Thredded::Engine => '/forum'
  mount ActionCable.server => '/cable'
  get '/private_topic', to: 'thredded/private_topics#index'

  resources :notifications do
    member do
      get :mark_as_read
    end
  end

  resources :followings, only: %w(new create destroy)
  resources :searches
  resources :photos
  resources :options
  resources :users
  resources :homes do
    resources :reviews
  end
  resources :conversations do
    resources :messages
  end
  resources :home_steps do
    collection do
      post 'add_photos'
    end
  end

  root 'homes#index'
  get  '/forum', to: 'comments#index'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create_omni'
  get 'auth/failure', to: redirect('/')
end
