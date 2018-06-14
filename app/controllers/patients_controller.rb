class PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to patients_path
    else
      render :new
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
      :active,
      :temporary,
      :birthday,
      :sex,
      :email,
      :phone,
      :cell_phone,
      :address,
      :city,
      :state,
      :zip_code
    )
  end
end