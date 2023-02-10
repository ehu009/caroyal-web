Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'application#home'

  get '/dev', to: 'application#dev'

  
  resources :prices, except: [:show]

  get 'price_data', to: "prices#price_data", as: :price_data
  get 'user_stats', to: "users#stats", as: :user_stats

  resources :users, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  get 'account', to: 'application#account_overview', as: :account_overview

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'


end
