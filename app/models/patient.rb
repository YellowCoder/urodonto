class Patient < ApplicationRecord
  enum sex: [:male, :female]

  has_many :appointments
  has_many :financial_records

  validates :name, presence: true
end