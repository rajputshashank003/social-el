Rails.application.routes.draw do
  root 'linkedin_posts#index'

  get "/auth/:provider", to: "sessions#omniauth_login", as: :oauth_login
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: "sessions#failure"
  delete "/logout", to: "sessions#destroy", as: :signout

  resources :linkedin_posts, only: [:index, :create]

  resources :tweets, only: [:new, :create]
end
