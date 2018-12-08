Rails.application.routes.draw do
  root 'dashboard#index'

  resources :users
  get 'signup', to: 'users#new'
end
