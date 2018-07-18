class SearchsController < ApplicationController
  def patients_to_agenda
    @patients = Patient.search_by_name(params[:q])
  
    respond_to do |format|
      format.json {
        @patients = @patients.limit(5)
      }
    end
  end

  def appointments_to_financial_record
    @appointments = Appointment.search_by_title_and_patient_name(params[:q])
                      .chargeable_without_payment
  
    respond_to do |format|
      format.json {}
    end
  end
end