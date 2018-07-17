class AppointmentDecorator < Draper::Decorator
  delegate_all
  
  def payment_status
    case
    when object.financial_record.blank? && object.chargeable? && object.delayed? then 'Atrasado'
    when object.financial_record.blank? && object.chargeable? then 'Aberto'
    when object.financial_record.blank? && !object.chargeable? then 'Gratuito'
    else
      'Pago'
    end
  end

  def payment_link_or_label
    return payment_status unless object.financial_record
    h.link_to payment_status, h.financial_record_path(object.financial_record)
  end
end