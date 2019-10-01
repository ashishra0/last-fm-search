Rails.application.routes.draw do
  resources :users, only: [:create, :edit, :update]
  resources :sessions, only: [:create]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root 'artists#index'
end
