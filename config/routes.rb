Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  
  root to: 'scheduler#index'

  resources :users
  resources :patients, path: 'pacientes', path_names: { new: 'novo' }
  resources :financial_records, path: 'financeiro', path_names: { new: 'novo', edit: 'alterar' } do
    collection do
      get '/:appointment_id/novo', to: 'financial_records#new_for_appointment', as: :appointment
    end
  end
  resources :appointments, path: 'consultas', path_names: { new: 'nova', edit: 'alterar' }
  resources :scheduler, path: 'agenda', path_names: { new: 'nova', edit: 'alterar' } do
    put :change_status, as: :member
  end
  resources :overviews, path: 'planilha', only: :index

  scope '/search' do
    get '/appointments-to-financial-record', to: 'searchs#appointments_to_financial_record', as: :search_appointments_for_payments, defaults: { format: 'json' }
    get '/patients-to-agenda', to: 'searchs#patients_to_agenda', as: :search_patients, defaults: { format: 'json' }
  end
end
