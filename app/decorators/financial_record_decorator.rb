class FinancialRecordDecorator < Draper::Decorator
  delegate_all
  decorates_association :appointment

  delegate :amount, to: :appointment

  def title
    object.title || "Consulta do dia: #{ appointment.start }"
  end
end