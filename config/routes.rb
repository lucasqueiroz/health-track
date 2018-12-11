Rails.application.routes.draw do
  root 'dashboard#index'

  resources :users, only: [:new, :create]
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :heights, except: [:show]
  resources :weights, except: [:show]
  resources :workouts, except: [:show]
  resources :foods, except: [:show]

  namespace :api do
    resources :users
    resources :heights
    resources :weights
  end
end
