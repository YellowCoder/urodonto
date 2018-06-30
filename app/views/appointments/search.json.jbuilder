json.array! @appointments do |appointment|
  json.id appointment.id
  json.title appointment.title.blank? ? 'Sem título' : appointment.title
  json.description "#{ appointment.start.strftime('%d-%m-%Y') } | #{ appointment.patient.name } | #{ t("activerecord.attributes.appointment.statuses.#{ appointment.status }") } | #{ t("activerecord.attributes.financial_record.statuses.#{ appointment.financial_record.status }") }"
end