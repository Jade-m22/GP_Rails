Rails.application.routes.draw do
  root to: "welcome#show"
  get "welcome(/:first_name)", to: "welcome#show", as: "welcome"


  get "/team", to: "static_pages#team", as: :static_pages_team
  get "/contact", to: "static_pages#contact", as: :static_pages_contact

  get "up" => "rails/health#show", as: :rails_health_check

  resources :gossips do
    resources :comments
  end
  
  resources :users, only: [ :show, :new, :create ]
  get '/users/suggestions', to: 'users#suggestions'
  
  resources :cities, only: [ :show ]

  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :gossips do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end  

end
