class AppointmentDecorator < Draper::Decorator
  delegate_all
  
  def payment_status
    return :free unless appointment.chargeable?
    return :free if ['scheduled', 'missed', 'rescheduled'].include?(appointment.status) && appointment.financial_record.blank?
    return :overdue if appointment.delayed? && appointment.financial_record.blank? && appointment.status == 'confirmed'
    return :not_paid if appointment.chargeable? && appointment.financial_record.blank? && appointment.status == 'confirmed'
    :paid
  end

  def payment_link_or_label
    return statuses[payment_status][:label] if object.financial_record.blank?
    h.link_to statuses[payment_status][:label], h.financial_record_path(object.financial_record)
  end

  def status_humanized
    h.t("activerecord.attributes.appointment.statuses.#{ object.status }")
  end

  def payment_color
    statuses[payment_status][:color]
  end

  def statuses
    {
      paid: { label: 'Pago', color: 'green' },
      overdue: { label: 'Atrasado', color: 'red' },
      not_paid: { label: 'Aberto', color: 'yellow' },
      free: { label: 'Gratuito', color: 'gray' }
    }
  end
end