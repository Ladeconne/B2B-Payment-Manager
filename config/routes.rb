Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get '/dashboard', to: 'pages#dashboard', as: :dashboard
  get '/invoices', to: 'pages#invoices', as: :invoices
  get '/payments', to: 'pages#payments', as: :payments

  resources :profiles, only: [:new, :create]
  resources :transactions, only: [:create]


end
