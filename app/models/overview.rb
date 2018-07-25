class Overview
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :initial_date, :end_date

  def initialize(initial_date = DateTime.now, end_date = DateTime.now)
    @initial_date = initial_date
    @end_date = end_date
  end

  def date_range
    (initial_date..end_date)
  end

  def persisted?
    false
  end
end