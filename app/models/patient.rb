class Patient < ApplicationRecord
  has_many :appointments
  has_many :financial_records

  validates :name, presence: true
end