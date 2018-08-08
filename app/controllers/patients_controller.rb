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
        :price,
        :_destroy
      ]
    )
  end
end