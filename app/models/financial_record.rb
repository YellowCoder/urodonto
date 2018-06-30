class FinancialRecord < ApplicationRecord
  enum status: [:paid, :partial_paid, :overdue, :free]

  belongs_to :user
  belongs_to :appointment

  monetize :amount_cents, with_currency: :brl
end