class Patient < ApplicationRecord
  # Includes
  include PgSearch

  # Extensions
  acts_as_paranoid
  has_paper_trail
  enum sex: [:male, :female]
  
  pg_search_scope :search_by_name,
    against: :name,
    using: { trigram: { threshold: 0.1 } },
    ignoring: :accents

  has_many :appointments
  has_many :financial_records, through: :appointments

  validates :name, presence: true
end