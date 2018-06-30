class FinancialRecord < ApplicationRecord
  enum status: [:paid, :overdue]

  belongs_to :doctor
  belongs_to :patient
  belongs_to :user
  belongs_to :appointment

  monetize :amount_cents, with_currency: :brl
end