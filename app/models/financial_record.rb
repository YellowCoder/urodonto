class FinancialRecord < ApplicationRecord
  # Extensions
  has_paper_trail
  acts_as_paranoid
  monetize :amount_cents, with_currency: :brl

  # Relationships
  belongs_to :user
  belongs_to :appointment

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :appointment, :user, :paid_at, presence: true
end