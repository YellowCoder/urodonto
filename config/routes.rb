Rails.application.routes.draw do
  devise_for :users
  
  root to: "application#index"

  resources :patients do
    get :autocomplete_patient_name, on: :collection
  end
  resources :doctors do
    get :autocomplete_doctor_name, on: :collection
  end
  resources :events do
    get :scheduler, on: :collection
  end
end
