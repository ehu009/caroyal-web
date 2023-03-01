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

  get 'privacy_policy', to: 'application#privacy_policy', as: :privacy_policy


  get '/dev', to: 'application#dev'

  
  resources :prices, except: [:show]

  get 'price_data', to: "prices#price_data", as: :price_data
  get 'user_stats', to: "users#stats", as: :user_stats


  get 'confirm_email', to: 'application#confirm_email', as: :confirm_email
  
  resources :users, only: [:index, :new, :create, :edit, :update, :show, :destroy]

  get 'welcome', to: 'application#first_time_login', as: :first_time_login
  get 'producer_questionaire', to: 'application#new_producer_questionaire', as: :new_producer_questionaire
  post 'producer_questionaire', to: 'application#fill_producer_questionaire', as: :fill_producer_questionaire
  get 'distributor_questionaire', to: 'application#new_distributor_questionaire', as: :new_distributor_questionaire
  post 'distributor_questionaire', to: 'application#fill_distributor_questionaire', as: :fill_distributor_questionaire

  get 'account', to: 'application#account_overview', as: :account_overview

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'


  resources :newsletter_subscriber, only: [:new, :create, :destroy]

  scope 'newsletter' do
    get 'subscribe', to: 'newsletter_subscriber#new', as: :new_newsletter_subscription
    post 'subscribe', to: 'newsletter_subscriber#create', as: :create_newsletter_subscription
    post 'unsubscribe/:unsubscribe_token', to: 'newsletter_subscriber#destroy', as: :unsubscribe_newsletter
  end

end
