class Patient < ApplicationRecord
  # Includes
  include PgSearch

  # Extensions
  acts_as_paranoid
  has_paper_trail
  enum sex: [:male, :female]
  monetize :fixed_price_cents, with_currency: :brl
  
  pg_search_scope :search_by_name,
    against: :name,
    using: { trigram: { threshold: 0 } },
    ignoring: :accents

  has_many :appointments, dependent: :destroy
  has_many :financial_records, through: :appointments
  has_many :patient_prices, inverse_of: :patient
  accepts_nested_attributes_for :patient_prices, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end