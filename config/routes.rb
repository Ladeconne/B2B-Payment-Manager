Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Profile controller

  resources :profiles, only: [:new, :create]
  get '/profiles/:id/dashboard', to: 'profiles#dashboard', as: :dashboard
  resources :transactions, only: [:create]
end
