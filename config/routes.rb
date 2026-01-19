Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get 'health', to: 'api/v1/health#index'

  post '/webhooks/stripe', to: 'webhooks/stripe#receive'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show]
      resources :subscriptions, only: %i[create]
      post 'auth/login', to: 'auth#login'
      post 'auth/signup', to: 'auth#signup'
    end
  end
end
