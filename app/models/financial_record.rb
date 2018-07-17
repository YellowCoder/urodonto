class FinancialRecord < ApplicationRecord
  # Extensions
  has_paper_trail
  acts_as_paranoid
  enum status: [:free, :not_paid, :paid, :overdue]
  monetize :amount_cents, with_currency: :brl

  # Relationships
  belongs_to :user
  belongs_to :appointment
end