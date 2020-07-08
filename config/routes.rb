Rails.application.routes.draw do
  # Index page
  root 'static#index'

  # Users
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resource :users, only: :create
end
