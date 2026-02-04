Rails.application.routes.draw do
  resources :kinds
  resources :contacts

  get "up" => "rails/health#show", as: :rails_health_check
end
