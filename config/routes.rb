Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root to: "scheduler#index"

  resources :patients do
    get :autocomplete_patient_name, on: :collection
  end
  resources :doctors do
    get :autocomplete_doctor_name, on: :collection
  end
  resources :financial_records
  resources :appointments
  resources :scheduler
end
