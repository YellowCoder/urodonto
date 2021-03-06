class AppointmentsController < ApplicationController
  include WithCurrentUser
  after_action :update_user_appointments, only: [:create, :update, :destroy]

  def index
    @appointments = Appointment.all.includes(:patient, :financial_record).decorate
  end

  def new
    @appointment = Appointment.new(payment_due: DateTime.now.end_of_month)
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def show
    @appointment = Appointment.find(params[:id]).decorate
  end

  def create
    @appointment = with_current_user(Appointment.new(appointment_params))
    unless @appointment.save
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

  private

  def update_user_appointments
    PatientAppointmentsUpdater.new(@appointment.patient).run!
  end

  def appointment_params
    params.require(:appointment).permit(
      :chargeable,
      :status,
      :patient_id,
      :title,
      :payment_due,
      :start,
      :end,
      :color
    )
  end
end