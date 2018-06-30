class Appointment < ApplicationRecord
  include PgSearch

  pg_search_scope :search_by_title_and_patient_name,
    against: :title,
    associated_against: {
      patient: [:name]
    },
    using: { trigram: { threshold: 0.1 } },
    ignoring: :accents
  acts_as_paranoid

  enum status: [:scheduled, :confirmed, :missed, :canceled]

  belongs_to :user
  belongs_to :patient
  belongs_to :doctor
  has_one :financial_record

  validates :doctor, :patient, :user, :start, :end, presence: true

  def all_day?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end