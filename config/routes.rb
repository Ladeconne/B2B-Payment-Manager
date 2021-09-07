Rails.application.routes.draw do
  get 'profiles/new'
  get 'profiles/edit'
  get 'profiles/show'
  get 'profiles/delete'
  devise_for :users
  root to: 'pages#home'
end
