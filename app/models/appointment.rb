class Appointment < ApplicationRecord
  enum status: [:scheduled, :confirmed, :missed, :canceled]

  belongs_to :user
  belongs_to :patient
  belongs_to :doctor

  validates :doctor, :patient, :user, :start, :end, presence: true

  def all_day?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end