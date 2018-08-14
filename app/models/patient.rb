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

  # Relationships
  has_many :appointments, dependent: :destroy
  has_many :financial_records, through: :appointments
  has_many :patient_prices, inverse_of: :patient
  accepts_nested_attributes_for :patient_prices, reject_if: :all_blank, allow_destroy: true

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }, email: true, allow_blank: true
  validates :fixed_price, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_duplication_on_prices

  # Scopes
  scope :with_appointment_between, lambda { |date_range|
    joins(:appointments).where('appointments.start' => date_range)
  }
  scope :ordered_by_name, -> { order(:name) }

  private

  def validate_duplication_on_prices
    return if patient_prices.blank?
    equals = patient_prices.reject(&:marked_for_destruction?).group_by(&:date).map{ |_, prices| prices.size }.max
    if equals > 1
      errors.add(:base, 'Você não ter parcelas duplicadas para o mesmo mês.')
    end
  end
end