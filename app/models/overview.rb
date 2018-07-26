class Overview
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :params, :initial_date, :end_date

  def initialize(params)
    @params = params
    @initial_date = first_month
    @end_date = second_month
  end

  def date_range
    (initial_date..end_date)
  end

  def persisted?
    false
  end

  def groupped_months
    date_range.map{ |date| date.strftime('%Y%m') }.uniq.map do |year_and_month|
      date = Date.parse("#{ year_and_month }01")
      OpenStruct.new(
        label: "#{ Date::ABBR_MONTHNAMES[ Date.strptime(year_and_month, '%Y%m').mon ] }/#{ year_and_month[0..3] }",
        range: (date.beginning_of_month..date.end_of_month)
      )
    end
  end

  def patients_list
    patients = Patient.all.map do |patient|
      appointments = {}
      groupped_months.each do |date_range|
        appointments[date_range.label] = foo(patient, date_range.range)
      end
      OpenStruct.new(
        name: patient.name,
        appointments: appointments
      )
    end

    OverviewDecorator.decorate_collection(patients)
  end

  def foo(patient, date_range)
    patient.appointments.where(start: date_range)
  end

  def first_month
    return DateTime.now unless params
    Date.parse("#{ params['initial_date(1i)'] }-#{ params['initial_date(2i)'] }-01")
  end

  def second_month
    return DateTime.now unless params
    Date.parse("#{ params['end_date(1i)'] }-#{ params['end_date(2i)'] }-01")
  end
end