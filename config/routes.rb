Rails.application.routes.draw do
  # Index page
  root 'static#index'

  # Users
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'

  # Sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # Posts
  resources :posts, only: %i(new create)
end
