Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root to: "scheduler#index"

  resources :patients do
    get :search, on: :collection
  end
  resources :financial_records do
    get :overview, on: :collection
  end
  resources :appointments do
    get :search, on: :collection
  end
  resources :scheduler
end
