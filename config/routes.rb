Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Profile controller
  get '/dashboard', to: 'pages#dashboard', as: :dashboard

  resources :profiles, only: [:new, :create]
  resources :transactions, only: [:create]


end
