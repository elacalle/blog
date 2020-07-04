Rails.application.routes.draw do
  # Index page
  root 'static#index'

  # users
  get 'signup', to: 'users#new', as: :signup
end
