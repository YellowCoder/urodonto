class Event < ApplicationRecord
  belongs_to :user
  belongs_to :patient
  belongs_to :doctor

  attr_accessor :date_range

  validates :title, :doctor, :patient, :user, :start, :end, presence: true

  def all_day_event?
    self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  end
end