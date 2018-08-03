class PatientPrice < ApplicationRecord
  # Extensions
  monetize :price_cents, with_currency: :brl

  # Relationships
  belongs_to :patient

  # Validations
  validates :patient, :date, presence: true
  validates :price_cents, presence: true, numericality: { greater_than_or_equal_to: 0 }
end