class Patient < ApplicationRecord
  acts_as_paranoid
  
  enum sex: [:male, :female]

  has_many :appointments
  has_many :financial_records

  validates :name, presence: true
end