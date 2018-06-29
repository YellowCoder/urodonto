class SchedulerController < ApplicationController
  def index
    @appointments = Appointment.where(start: params[:start]..params[:end])
  end

  def new
    @appointment = Appointment.new
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.user = current_user
    unless @appointment.save
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def update
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_params)
    unless @appointment.save
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
  end

  private

  def appointment_params
    params.require(:appointment).permit(
      :doctor_id,
      :patient_id,
      :title,
      :start,
      :end,
      :color
    )
  end
end