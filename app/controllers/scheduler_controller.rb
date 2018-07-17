class SchedulerController < ApplicationController
  include WithCurrentUser

  def index
    @appointments = Appointment.where(start: params[:start]..params[:end]).includes(:patient)
  end

  def new
    @appointment = Appointment.new
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def create
    @appointment = with_current_user(Appointment.new(appointment_params))
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
      :patient_id,
      :chargeable,
      :status,
      :title,
      :payment_due,
      :start,
      :end,
      :color
    )
  end
end