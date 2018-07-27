class PatientPrice < ApplicationRecord
  # Relationships
  belongs_to :patient

  # Validations
  validates :patient, :date, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end