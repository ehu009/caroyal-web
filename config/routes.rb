Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'application#home'

  get 'about', to: 'application#about', as: :about
  get 'products', to: 'application#products', as: :products
  get 'contact', to: 'application#contact', as: :contact
  get 'timeline', to: 'application#timeline', as: :timeline
  get 'blog', to: 'blog#lander', as: :blog
  get 'market', to: 'market#lander', as: :market

  get 'privacy', to: 'application#privacy_policy', as: :privacy_policy
  get '/dev', to: 'application#dev'

  
  resources :prices, except: [:show]

  get 'price_data', to: "prices#price_data", as: :price_data
  get 'user_stats', to: "users#stats", as: :user_stats


  get 'confirm_email', to: 'application#confirm_email', as: :confirm_email
  
  resources :users, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    patch 'change_password', to: "users#change_pwd", as: :change_password
    patch 'change_phone', to: "users#change_phone", as: :change_phone
  end

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  get 'welcome', to: 'sessions#first_time_login', as: :first_time_login
  get 'account', to: 'sessions#account_overview', as: :account_overview

  scope 'questionaires' do
    get 'producer', to: 'questionaires#new_producer_questionaire', as: :new_producer_questionaire
    post 'producer', to: 'questionaires#fill_producer_questionaire', as: :fill_producer_questionaire
    get 'distributor', to: 'questionaires#new_distributor_questionaire', as: :new_distributor_questionaire
    post 'distributor', to: 'questionaires#fill_distributor_questionaire', as: :fill_distributor_questionaire
  end

  


  resources :newsletter do
    get 'dispatch/:id', to: 'newsletter#dispatch_latest', as: :newsletter_dispatch
  end

  scope 'newsletter' do
    get 'subscribe', to: 'newsletter_subscriber#new', as: :new_newsletter_subscription
    post 'subscribe', to: 'newsletter_subscriber#create', as: :create_newsletter_subscription
    get 'unsubscribe/:unsubscribe_token', to: 'newsletter_subscriber#destroy', as: :unsubscribe_newsletter
  end

end
