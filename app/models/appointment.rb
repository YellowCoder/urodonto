class Appointment < ApplicationRecord
  # Includes
  include PgSearch
  include AppointmentPayments

  # Extensions
  has_paper_trail
  acts_as_paranoid
  enum status: [:scheduled, :confirmed, :missed, :rescheduled]
  pg_search_scope :search_by_title_and_patient_name,
    against: :title,
    associated_against: {
      patient: [:name]
    },
    using: { trigram: { threshold: 0 } },
    ignoring: :accents

  # Relationships
  belongs_to :user
  belongs_to :patient
  has_one :financial_record, dependent: :destroy

  # Validations
  validates :patient, :user, :start, :end, :payment_due, presence: true

  # Scopes
  scope :chargeables, -> { where(chargeable: true) }
  scope :non_chargeables, -> { where(chargeable: false) }
  scope :paid, -> { joins(:financial_record) }
  scope :with_overdue_payments, lambda {
    joins('FULL OUTER JOIN financial_records ON appointments.id = financial_records.appointment_id AND financial_records.deleted_at IS NULL').
    where('appointments.id IS NULL OR financial_records.appointment_id IS NULL').
    where('appointments.chargeable = TRUE').
    where(['appointments.payment_due < ?', DateTime.now]).
    where('financial_records.deleted_at IS NULL')
  }
  scope :without_overdue_payments, lambda {
    joins('FULL OUTER JOIN financial_records ON appointments.id = financial_records.appointment_id AND financial_records.deleted_at IS NULL').
    where('appointments.id IS NULL OR financial_records.appointment_id IS NULL').
    where('appointments.chargeable = TRUE').
    where(['appointments.payment_due > ?', DateTime.now]).
    where('financial_records.deleted_at IS NULL')
  }
  scope :chargeable_without_payment, lambda {
    joins('FULL OUTER JOIN financial_records ON appointments.id = financial_records.appointment_id AND financial_records.deleted_at IS NULL').
    where('appointments.id IS NULL OR financial_records.appointment_id IS NULL').
    where(['appointments.chargeable = ?', true])
  }

  def all_day?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end

  def price
    patient.fixed_price
  end
end