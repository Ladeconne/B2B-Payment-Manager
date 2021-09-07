Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/dashboard', to: 'pages#dashboard', as: :dashboard

  # Profile controller
  get "/profiles/new", to: "profiles#new", as: "new_profile"
  post "/profiles", to: "profiles#create"
end
