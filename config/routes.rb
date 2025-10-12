Rails.application.routes.draw do
  resources :contacts

  get "up" => "rails/health#show", as: :rails_health_check
end
