Rails.application.routes.draw do
  get "gossips/show"
  root to: "welcome#show"
  get "welcome(/:first_name)", to: "welcome#show", as: "welcome"


  get "/team", to: "static_pages#team", as: :static_pages_team
  get "/contact", to: "static_pages#contact", as: :static_pages_contact

  get "up" => "rails/health#show", as: :rails_health_check

  resources :gossips, except: [:destroy, :edit, :update] do
    resources :comments
  end
  
  resources :users, only: [:show, :new, :create]
  

end
