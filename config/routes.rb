Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/profiles/new", to: "profiles#new", as: "new_profile"
  post "/profiles", to: "profiles#create"
end
