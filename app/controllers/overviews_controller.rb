class OverviewsController < ApplicationController
  def index
    initial_date = params[:overview].present? ? Date.parse("#{params[:overview]['initial_date(1i)']}-#{params[:overview]['initial_date(2i)']}-01") : DateTime.now
    end_date = params[:overview].present? ? Date.parse("#{params[:overview]['end_date(1i)']}-#{params[:overview]['end_date(2i)']}-01") : DateTime.now

    @overview_date = Overview.new(initial_date, end_date)

    p "----"
    p @overview_date.date_range
    p "----"

    @date_range = @overview_date.date_range.map{ |m| m.strftime('%Y%m') }.uniq.map do |m| 
      date = Date.parse("#{ m }01")
      {
        label: "#{ Date::ABBR_MONTHNAMES[ Date.strptime(m, '%Y%m').mon ] }/#{ m[0..3] }",
        range: (date.beginning_of_month..date.end_of_month)
      }
    end

    patients = Patient.all.map do |patient|
      appointments = {}
      @date_range.each do |date_range|
        appointments[date_range[:label]] = foo(patient, date_range[:range])
      end
      {
        id: patient.id,
        name: patient.name,
        appointments: appointments
      }
    end

    @overview = OverviewDecorator.decorate_collection(patients)
  end

  def foo(patient, date_range)
    patient.appointments.where(start: date_range)
  end

  private

  def overviews_params
    params.permit(
      :initial_date,
      :end_date
    )
  end
end