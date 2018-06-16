class DoctorsController < ApplicationController
  autocomplete :doctor, :name, additional_data: [:id], label_method: :test, full_model: true
end