class Patient < ApplicationRecord
  include PgSearch
  
  pg_search_scope :search_by_name,
    against: :name,
    using: { trigram: { threshold: 0.1 } },
    ignoring: :accents

  acts_as_paranoid
  
  enum sex: [:male, :female]

  has_many :appointments
  has_many :financial_records, through: :appointments

  validates :name, presence: true
end