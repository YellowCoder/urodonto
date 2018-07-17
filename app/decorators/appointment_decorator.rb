class AppointmentDecorator < Draper::Decorator
  # delegate :status, :patient, :title, :start, :end
  delegate_all
  
  def payment_link_or_label
    case
    when object.financial_record.blank? && object.start.month < DateTime.now.month then 'Atrasado'
    when object.financial_record.blank? && object.chargeable? then 'Aberto'
    when object.financial_record.blank? && !object.chargeable? then 'Gratuito'
    end
  end
end