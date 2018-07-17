json.array! @appointments do |appointment|
  json.id appointment.id
  json.patient_name appointment.patient.name
  json.title_description "Consulta do dia: #{ appointment.start.strftime('%d/%m/%Y') }"
  json.date appointment.start.strftime('%d/%m/%Y')
  json.description "#{ appointment.title || 'Sem título' }  |  #{ appointment.start.strftime('%d-%m-%Y') }  |  #{ t("activerecord.attributes.appointment.statuses.#{ appointment.status }") }"
  json.payment_due appointment.payment_due.strftime('%d/%m/%Y')
  json.delayed appointment.delayed?
  json.price humanized_money(appointment.price)
end