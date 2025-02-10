Rails.application.routes.draw do
  root to: "static_pages#home"
  get "welcome(/:first_name)", to: "static_pages#welcome", as: "welcome"


  get "/team", to: "static_pages#team", as: :static_pages_team
  get "/contact", to: "static_pages#contact", as: :static_pages_contact

  get "up" => "rails/health#show", as: :rails_health_check
end
