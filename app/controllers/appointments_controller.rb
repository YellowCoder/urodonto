class AppointmentsController < ApplicationController
  def index
    @appointments = Appointment.all
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
    @appointment.user = current_user
    
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

  def search
    @appointments = Appointment.search_by_title_and_patient_name(params[:q])
  
    respond_to do |format|
      format.json {
        @appointments = @appointments.limit(5)
      }
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(
      :status,
      :doctor_id,
      :patient_id,
      :title,
      :start,
      :end,
      :color
    )
  end
end