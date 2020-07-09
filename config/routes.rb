Rails.application.routes.draw do
  # Index page
  root 'static#index'

  # Sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  # Users
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  resource :users, only: :create
end
