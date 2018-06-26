Rails.application.routes.draw do
  devise_for :users
  
  root to: "application#index"

  resources :patients, path: 'pacientes' do
    get :autocomplete_patient_name, on: :collection
  end
  resources :doctors, path: 'doutores' do
    get :autocomplete_doctor_name, on: :collection
  end
  resources :events, path: 'agendamentos' do
    get :scheduler, on: :collection
  end
  resources :scheduler, path: 'agendamento'
end
