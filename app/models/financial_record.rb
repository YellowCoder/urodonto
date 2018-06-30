class FinancialRecord < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  belongs_to :user
  belongs_to :appointment
end