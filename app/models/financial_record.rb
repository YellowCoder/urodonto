class FinancialRecord < ApplicationRecord
  acts_as_paranoid
  
  enum status: [:not_paid, :paid, :overdue, :free]

  belongs_to :user
  belongs_to :appointment

  monetize :amount_cents, with_currency: :brl
end