class Appointment < ApplicationRecord
  # Includes
  include PgSearch

  # Extensions
  has_paper_trail
  acts_as_paranoid
  enum status: [:scheduled, :confirmed, :missed, :canceled, :free]

  pg_search_scope :search_by_title_and_patient_name,
    against: :title,
    associated_against: {
      patient: [:name]
    },
    using: { trigram: { threshold: 0.1 } },
    ignoring: :accents

  belongs_to :user
  belongs_to :patient
  belongs_to :doctor
  has_one :financial_record, dependent: :destroy

  validates :doctor, :patient, :user, :start, :end, presence: true

  def all_day?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end