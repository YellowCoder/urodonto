class AppointmentDecorator < Draper::Decorator
  delegate_all
  decorates_association :financial_record
  
  def payment_link_or_label
    return payment_label if object.financial_record.blank?
    h.link_to payment_label, h.financial_record_path(object.financial_record)
  end

  def status_humanized
    h.t("activerecord.attributes.appointment.statuses.#{ object.status }")
  end

  def payment_color
    statuses[object.payment_status][:color]
  end

  def payment_label
    statuses[object.payment_status][:label]
  end

  def payment_due
    object.payment_due.strftime('%d/%m/%Y')
  end

  def start_date
    object.start.strftime('%d/%m/%Y')
  end

  def start
    object.start.strftime('%d/%m/%Y - %H:%M')
  end

  def end
    object.end.strftime('%d/%m/%Y - %H:%M')
  end

  def range_period
    "#{ object.start.strftime('%d/%m/%Y') } (#{ object.start.strftime('%H:%M') } - #{ object.end.strftime('%H:%M') })"
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