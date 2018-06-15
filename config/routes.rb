Rails.application.routes.draw do
  devise_for :users
  
  root to: "application#index"

  resources :patients
  resources :events do
    get :scheduler, on: :collection
  end
end
