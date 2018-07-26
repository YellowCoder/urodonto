class OverviewDecorator < Draper::Decorator
  delegate_all

  def decorate_appointments_for(date)
    statuses = object[:appointments][date[:label]].map do |appointment| 
      AppointmentDecorator.decorate(appointment)
    end
    return [OpenStruct.new(label: '--', payment_color: '')] if statuses.blank?
    statuses
  end
end