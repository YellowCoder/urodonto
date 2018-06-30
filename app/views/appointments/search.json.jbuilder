json.array! @appointments do |appointment|
  json.title "#{ appointment.title } - #{ appointment.patient.name }"
end