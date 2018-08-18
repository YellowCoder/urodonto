class PatientAppointmentsUpdater
  attr_reader :patient

  def initialize(patient)
    @patient = patient
  end

  def run!
    patient.update_column(:grouped_appointments, mapped_appointments.group_by{ |x| x[:start].strftime('%m/%Y') })
  end

  def mapped_appointments
    patient.appointments.map do |appointment|
      OpenStruct.new(
        id: appointment.id,
        title: appointment.title,
        start: appointment.start,
        end: appointment.end,
        status: appointment.status,
        payment_status: appointment.payment_status
      )
    end
  end
end