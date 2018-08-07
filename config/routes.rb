Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root to: 'scheduler#index'

  resources :patients
  resources :financial_records
  resources :appointments
  resources :scheduler do
    put :change_status, as: :member
  end
  resources :overviews, only: :index

  scope '/search' do
    get '/appointments-to-financial-record', to: 'searchs#appointments_to_financial_record', as: :search_appointments_for_payments, defaults: { format: 'json' }
    get '/patients-to-agenda', to: 'searchs#patients_to_agenda', as: :search_patients, defaults: { format: 'json' }
  end
end
