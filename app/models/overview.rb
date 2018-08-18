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
        range: (date.beginning_of_month.beginning_of_day..date.end_of_month.end_of_day),
        key: date.strftime('%m/%Y') 
      )
    end
  end

  def patients_list
    patients = Patient.ordered_by_name.with_appointment_between(date_range).map do |patient|
      appointments = {}
      groupped_months.each do |date_range|
        appointments[date_range.label] = patient.grouped_appointments[date_range.key]
      end
      OpenStruct.new(
        id: patient.id,
        name: patient.name,
        appointments: appointments
      )
    end

    OverviewDecorator.decorate_collection(patients)
  end

  def first_month
    return DateTime.now unless params
    Date.parse("#{ params['initial_date(1i)'] }-#{ params['initial_date(2i)'] }-01")
  end

  def second_month
    return DateTime.now unless params
    Date.parse("#{ params['end_date(1i)'] }-#{ params['end_date(2i)'] }-01").end_of_month
  end
end