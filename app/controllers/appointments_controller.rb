class AppointmentsController < ApplicationController
  include WithCurrentUser

  def index
    @appointments = Appointment.all.includes(:patient, :financial_record)
  end

  def new
    @appointment = Appointment.new
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.extend(AppendFinancialRecord)
    unless with_current_user(@appointment).save
      render :new
    else
      redirect_to appointments_path
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    if @appointment.update(appointment_params)
      redirect_to appointments_path
    else
      render :new
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_path
  end

  def search
    @appointments = Appointment.search_by_title_and_patient_name(params[:q])
  
    respond_to do |format|
      format.json {}
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(
      :chargeable,
      :status,
      :patient_id,
      :title,
      :start,
      :end,
      :color
    )
  end
end