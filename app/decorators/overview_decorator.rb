class OverviewDecorator < Draper::Decorator
  delegate_all

  def foo(date)
    statuses = object[:appointments][date[:label]].map do |appointment| 
      {
        appointment: appointment,
        label: h.t("activerecord.attributes.appointment.statuses.#{ appointment.status }"),
        color: colors[appointment_status(appointment)]
      }
    end
    return [{ label: '--', satus: '' }] if statuses.blank?
    statuses
  end

  def colors
    {
      paid: 'green',
      overdue: 'red',
      not_paid: 'yellow',
      free: 'gray'
    }
  end

  def status(date)
    object[:appointments][date[:label]].map do |appointment|
      appointment_status(appointment)
    end
  end

  def appointment_status(appointment)
    return :free unless appointment.chargeable?
    return :overdue if appointment.delayed? && appointment.financial_record.blank? && appointment.status == 'confirmed'
    return :not_paid if appointment.chargeable? && appointment.financial_record.blank?
    :paid
  end
end