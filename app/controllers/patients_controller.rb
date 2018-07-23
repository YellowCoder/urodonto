class PatientsController < ApplicationController
  def index
    @patients = Patient.all.includes(:appointments)
  end

  def new
    @patient = Patient.new
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to patients_path
    else
      render :new
    end
  end

  def update
    @patient = Patient.find(params[:id])

    if @patient.update_attributes(patient_params)
      redirect_to patients_path
    else
      render :edit
    end
  end

  def destroy
    @patient = Patient.find(params[:id])

    if @patient.destroy
      redirect_to patients_path
    else
      render :index
    end
  end

  def overview
    d1 = (DateTime.now - 1.month).beginning_of_month
    d2 = (DateTime.now + 3.months).end_of_month
    @date_range = (d1..d2).map{ |m| m.strftime('%Y%m') }.uniq.map do |m| 
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

  def patient_params
    params.require(:patient).permit(
      :name,
      :birthday,
      :sex,
      :fixed_price,
      :email,
      :phone,
      :cell_phone,
      :address,
      :city,
      :state,
      :zip_code,
      patient_prices_attributes: [
        :id,
        :date,
        :price_cents,
        :_destroy
      ]
    )
  end
end